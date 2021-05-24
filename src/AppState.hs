module AppState where

import  User
import Room
import Item

data AppState = AppState {user :: UserCharacter, rooms :: [(String, Room)], items :: [(String, Item)]} deriving Show
