module Room where

import Data.List

data RoomObject = Item | Monster deriving Show

data Room = Room {roomName :: String, otherRooms :: [String], roomObjects :: [RoomObject]} deriving Show

roomNameToOtherRooms :: String -> [Room] -> [String]
roomNameToOtherRooms currentRoomName (x:xs) 
    | currentRoomName == Room.roomName x = Room.otherRooms x
    | otherwise = roomNameToOtherRooms currentRoomName xs

roomNameToOtherRooms currentRoomName [] = []


