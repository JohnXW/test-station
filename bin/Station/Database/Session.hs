{-# LANGUAGE QuasiQuotes #-}

module Station.Database.Session (
	Type (Record, token, time, user),
	get, delete, add)
where

import Prelude ()
import Data.Bool (Bool)
import Data.Eq ((==))
import Data.List ((++), map)
import Data.String (String)
import Data.Functor (fmap, (<$>))
import Control.Applicative ((<*>))
import Control.Monad (return, void)
import Data.Time.LocalTime (LocalTime)
import System.IO (IO)
import qualified Database.PostgreSQL.Simple as DB
import qualified Database.PostgreSQL.Simple.ToField as DB
import qualified Database.PostgreSQL.Simple.ToRow as DB
import qualified Database.PostgreSQL.Simple.FromRow as DB
import Database.PostgreSQL.Simple.SqlQQ (sql)

import qualified Station.Database.User as DB.User

data Type =
	Record{
		token :: String,
		time :: LocalTime,
		user :: DB.User.Type}

instance DB.ToRow Type where
	toRow session =
		[
			DB.toField (token session),
			DB.toField (time session)]
			++ DB.toRow (user session)

instance DB.FromRow Type where
	fromRow = Record <$> DB.field <*> DB.field <*> DB.fromRow

get :: String -> DB.Connection -> IO [Type]
get session_token db =
	do
		sessions <-
			DB.query
				db
				[sql|
					SELECT "TOKEN","TIME","NAME","PASSWORD","ROLE","MARK","LOCK"
						FROM "SESSION"
						INNER JOIN "USER" ON "SESSION"."USER"="USER"."NAME"
						WHERE "TOKEN"=? |]
				(DB.Only session_token)
		case sessions of
			[] -> return ()
			_ ->
				void
					(DB.execute
						db
						[sql| UPDATE "SESSION" SET "TIME"=NOW() WHERE "TOKEN"=? |]
						(DB.Only session_token))
		return sessions

delete :: String -> DB.Connection -> IO Bool
delete session_token db = fmap (1 ==) (DB.execute db [sql| DELETE FROM "SESSION" WHERE "TOKEN"=? |] (DB.Only session_token))

add :: DB.User.Type -> DB.Connection -> IO [String]
add session_user db =
	fmap
		(map (\ (DB.Only session_token) -> session_token))
		(DB.query
			db
			[sql|
				INSERT INTO "SESSION"("TOKEN","TIME","USER")
					VALUES (
						ARRAY_TO_STRING(
							ARRAY(
								SELECT CHR(ASCII('A')+FLOOR(RANDOM()*26)::INTEGER)
								FROM GENERATE_SERIES(1,8)),
							'')
							|| NEXTVAL('"SESSION_TOKEN_seq"'),
						NOW(),
						?)
					RETURNING "TOKEN" |]
			(DB.Only (DB.User.name session_user)))
