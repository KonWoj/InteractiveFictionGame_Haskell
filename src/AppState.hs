module AppState where

import  User
import Room

data AppState = AppState {user :: UserCharacter, rooms :: [Room]} deriving Show
