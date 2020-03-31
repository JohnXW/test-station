module Station.Constant (
	Role,
	auth_realm, public_home, private_home, login_fail,
	session, session_age
) where

import Prelude (Integer)
import Data.String (IsString (fromString))

import qualified Station.Constant.Role

type Role = Station.Constant.Role.Type

auth_realm :: IsString s => s
auth_realm = fromString "Station"

public_home :: IsString s => s
public_home = fromString "/public/home.xhtml"

private_home :: IsString s => s
private_home = fromString "/home"

login_fail :: IsString s => s
login_fail = fromString "/public/login-fail.xhtml"

session :: IsString s => s
session = "session"

session_age :: Integer
session_age = 86400
