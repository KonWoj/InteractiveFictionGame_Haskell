module AppState where

import  User
import Room
import Item

{-
AppState type. Fields:
    user :: UserCharacter : user instance
    rooms :: [(String, Room)] : room set (list of (key: room name, value: room instance))
    items :: [(String, Item)] : item set (list of (key: item name, value: item instance))
-}
data AppState = AppState {user :: UserCharacter, rooms :: [(String, Room)], items :: [(String, Item)]} deriving Show
