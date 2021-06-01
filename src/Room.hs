module Room where

import Data.List

data RoomObject =  Monster deriving Show

data Room = Room {otherRooms :: [String], roomItems :: [String], roomObjects :: [RoomObject], onEnterMsg :: String} deriving Show

getOtherRooms :: String -> [(String, Room)] -> [String]
getOtherRooms roomName roomSet = maybe [] Room.otherRooms room
    where room = lookup roomName roomSet

getRoomItems :: String -> [(String, Room)] -> [String]
getRoomItems roomName roomSet = maybe [] Room.roomItems room
    where room = lookup roomName roomSet
