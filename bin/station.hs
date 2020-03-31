module Main (main) where

import Prelude (fromEnum)
import Data.Bool (Bool (True))
import Data.Maybe (Maybe (Nothing, Just), fromMaybe)
import Data.List ((++), (\\), lookup, sort)
import Data.Function (id, ($))
import Data.Functor ((<$>))
import Control.Monad (return, (>>=), (=<<))
import Text.Show (show)
import Text.Read (readMaybe)
import System.Exit (exitSuccess, exitFailure)
import System.FilePath (FilePath, (</>))
import System.IO (IO, stdout, putStrLn, BufferMode (LineBuffering), hSetBuffering)
import System.Environment (getArgs, lookupEnv)
import System.Directory (listDirectory)
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BS.C8
import qualified Crypto.Scrypt
import qualified Network.Wai as Wai
import qualified Network.Wai.Application.Static as Wai.Static
import qualified Network.Wai.Handler.Warp as Warp
import qualified Database.PostgreSQL.Simple as DB
import qualified Database.PostgreSQL.Simple.Types as DB (Query (Query))

import qualified Station.Constant as Constant
import qualified Station.Constant.Role as Constant.Role
import qualified Station.Database.User as DB.User
import qualified Station.Database.Session as DB.Session
import qualified Station.HTTP as HTTP
import qualified Station.Web as Web
import qualified Station.Web.Public as Public
import qualified Station.Web.Session as Session

{- -------------------------------------------------------------------------------------------------------------------------- -}

default_port :: Warp.Port
default_port = 8000

static_path :: FilePath
static_path = "www"

migration_path :: FilePath
migration_path = "sql/migration"

{- -------------------------------------------------------------------------------------------------------------------------- -}

handle_home :: Wai.Middleware
handle_home next request =
	case Wai.pathInfo request of
		[] -> HTTP.respond_301 Constant.public_home request
		_ -> next request

get_user :: DB.Connection -> Wai.Request -> IO (Maybe DB.User.Type)
get_user database request =
	case lookup Constant.session (HTTP.cookies request) of
		Nothing -> return Nothing
		Just token ->
			(\case
				session : _ -> Just (DB.Session.user session)
				_ -> Nothing)
				<$> DB.Session.get (BS.C8.unpack token) database

migrate :: DB.Connection -> IO ()
migrate database =
	do
		files <- listDirectory migration_path
		only_done <- DB.query_ database "SELECT \"FILE\" FROM \"MIGRATION\" ORDER BY \"FILE\""
		let
			done = DB.fromOnly <$> only_done
			todo = sort (files \\ done)
			loop [] = return ()
			loop (f : fs) =
				do
					putStrLn ("migrate: " ++ f)
					sql <- BS.readFile (migration_path </> f)
					_ <- DB.execute_ database (DB.Query sql)
					inserted <- DB.execute database "INSERT INTO \"MIGRATION\" (\"FILE\") VALUES (?)" (DB.Only f)
					case inserted of
						1 -> loop fs
						_ -> putStrLn "ERROR: unable modify migration record"
		loop todo

main :: IO ()
main =
	do
		hSetBuffering stdout LineBuffering
		port <- fromMaybe default_port <$> (readMaybe =<<) <$> lookupEnv "PORT"
		dburl <- fromMaybe "" <$> lookupEnv "DATABASE_URL"
		log <- fromMaybe True <$> (readMaybe =<<) <$> lookupEnv "LOG"
		putStrLn "Configuration"
		putStrLn ("\tport: " ++ show port)
		putStrLn ("\tdatabase: " ++ show dburl)
		putStrLn ("\tlog: " ++ show log)
		getArgs >>= \case
			[] ->
				do
					database <- DB.connectPostgreSQL (BS.C8.pack dburl)
					let handle request respond =
						do
							user' <- get_user database request
							(HTTP.log log
								$ handle_home
								$ Public.handle database
								$ case user' of
									Nothing ->
										case Wai.pathInfo request of
											"public" : _ -> id
											_ -> \ _ -> HTTP.respond_303 Constant.public_home
									Just user ->
										Web.handle
											Session.Record{
												Session.log = log,
												Session.database = database,
												Session.user = user}
								$ Wai.Static.staticApp (Wai.Static.defaultWebAppSettings static_path))
								request
								respond
					Warp.run port handle
			["adduser", username@(_:_), password@(_:_), role's@(_:_)] ->
				case readMaybe role's of
					Just role ->
						do
							database <- DB.connectPostgreSQL (BS.C8.pack dburl)
							encrypted <- Crypto.Scrypt.encryptPassIO' (Crypto.Scrypt.Pass (BS.C8.pack password))
							n <-
								DB.execute
									database
									"INSERT INTO \"USER\"(\"NAME\",\"PASSWORD\",\"ROLE\") VALUES(?,?,?)"
									(username, Crypto.Scrypt.getEncryptedPass encrypted, fromEnum (role :: Constant.Role.Type))
							case n of
								1 ->
									do
										putStrLn "OK"
										exitSuccess
								_ ->
									do
										putStrLn "Fail"
										exitFailure
					_ ->
						do
							putStrLn "Unknown role"
							exitFailure
			["migrate"] ->
				do
					database <- DB.connectPostgreSQL (BS.C8.pack dburl)
					migrate database
					DB.close database
			_ ->
				do
					putStrLn "Commands:"
					putStrLn "\t(no argument): start server"
					putStrLn "\thelp: display this documentation text"
					putStrLn "\tmigrate: apply database migrations (in sql/migration)"
					putStrLn "\tadduser {username} {password} {role}: add a new user"
					putStrLn "\t\trole: SysOp, or User (see bin/Station/Constant/Role.hs)"

{- -------------------------------------------------------------------------------------------------------------------------- -}
