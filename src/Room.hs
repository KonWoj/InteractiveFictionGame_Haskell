module Room where

import Data.List

{-
Room type. Fields:
    otherRooms :: [String] : list of possible rooms to go to
    roomItems :: [String] : list of items in the room
-}
data Room = Room {otherRooms :: [String], roomItems :: [String]} deriving Show

{-
Get other rooms
    first argument : room name
    second argument : room set (key: room name, value: room instance)

    returns : list of other rooms names
-}
getOtherRooms :: String -> [(String, Room)] -> [String]
getOtherRooms roomName roomSet = maybe [] Room.otherRooms room
    where room = lookup roomName roomSet

{-
Get room items 
    first argument : room name
    second argument : room set (key: room name, value: room instance)

    returns : list of items names
-}
getRoomItems :: String -> [(String, Room)] -> [String]
getRoomItems roomName roomSet = maybe [] Room.roomItems room
    where room = lookup roomName roomSet
