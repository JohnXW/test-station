module Station.Web.Public (handle) where

import Prelude ()
import Data.Bool (Bool (True), otherwise)
import Data.Eq ((==))
import Data.Maybe (Maybe (Nothing, Just))
import Data.Tuple (fst)
import Data.List (lookup)
import Data.Functor ((<$>))
import Control.Monad ((=<<))
import qualified Data.ByteString.Char8 as BS.C8
import qualified Data.ByteString.UTF8 as BS.U8
import Data.Time.Clock (secondsToDiffTime)
import qualified Network.HTTP.Types
import qualified Network.Wai as Wai
import qualified Network.Wai.Parse as Wai.Parse
import qualified Web.Cookie as Cookie

import qualified Station.Constant as Constant
import qualified Station.Database as DB
import qualified Station.Database.User as DB.User
import qualified Station.Database.Session as DB.Session
import qualified Station.HTTP as HTTP

handle_login :: DB.Type -> Wai.Application
handle_login database request respond
	| Wai.requestMethod request == Network.HTTP.Types.methodPost =
		do
			parameters <- fst <$> Wai.Parse.parseRequestBody Wai.Parse.lbsBackEnd request
			case (lookup "username" parameters, lookup "password" parameters) of
				(Just username', Just password') ->
					(\case
						[] -> HTTP.respond_303 Constant.login_fail request respond
						user : _ ->
							(\case
								session : _ ->
									HTTP.respond_303_headers
										[
											HTTP.set_cookie_header
												Cookie.defaultSetCookie{
													Cookie.setCookieName = Constant.session,
													Cookie.setCookieValue = BS.C8.pack session,
													Cookie.setCookiePath = Just "/",
													Cookie.setCookieMaxAge = Just (secondsToDiffTime Constant.session_age),
													Cookie.setCookieHttpOnly = True,
													Cookie.setCookieSameSite = Just Cookie.sameSiteStrict}]
										Constant.private_home
										request
										respond
								_ -> HTTP.respond_500 "Cannot create session" request respond)
								=<< DB.Session.add user database)
						=<< DB.User.check_password (BS.U8.toString username') password' database
				_ -> HTTP.respond_303 Constant.login_fail request respond
	| otherwise =
		HTTP.respond_405 request respond

handle_logout :: DB.Type -> Wai.Application
handle_logout database request respond
	| Wai.requestMethod request == Network.HTTP.Types.methodGet =
		case lookup Constant.session (HTTP.cookies request) of
			Nothing -> HTTP.respond_303 Constant.public_home request respond
			Just token ->
				do
					_ <- DB.Session.delete (BS.C8.unpack token) database
					let
						cookie_header =
							HTTP.set_cookie_header
								Cookie.defaultSetCookie{
									Cookie.setCookieName = Constant.session,
									Cookie.setCookieValue = "",
									Cookie.setCookiePath = Just "/",
									Cookie.setCookieMaxAge = Just 0}
					HTTP.respond_303_headers [cookie_header] Constant.public_home request respond
	| otherwise =
		HTTP.respond_405 request respond

handle :: DB.Type -> Wai.Middleware
handle database next request respond =
	case Wai.pathInfo request of
		["public", "login"] -> handle_login database request respond
		["public", "logout"] -> handle_logout database request respond
		_ -> next request respond
