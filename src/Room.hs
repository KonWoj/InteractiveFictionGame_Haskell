module Room where

import Data.List

data RoomObject =  Monster deriving Show

data Room = Room {otherRooms :: [String], roomItems :: [String], roomObjects :: [RoomObject]} deriving Show

getOtherRooms :: String -> [(String, Room)] -> [String]
getOtherRooms roomName roomSet = maybe [] Room.otherRooms room
    where room = lookup roomName roomSet

getRoomItems :: String -> [(String, Room)] -> [String]
getRoomItems roomName roomSet = maybe [] Room.roomItems room
    where room = lookup roomName roomSet

-- roomNameToOtherRooms :: String -> [Room] -> [String]
-- roomNameToOtherRooms currentRoomName (x:xs) 
--     | currentRoomName == Room.roomName x = Room.otherRooms x
--     | otherwise = roomNameToOtherRooms currentRoomName xs
-- roomNameToOtherRooms currentRoomName [] = []

-- getRoomByName :: String -> [Room] -> Maybe Room
-- getRoomByName roomName (x:xs)
--     | roomName == Room.roomName x = Just x
--     | otherwise = getRoomByName roomName xs
-- getRoomByName _ [] = Nothing

-- getOtherRooms :: Maybe Room -> [String]
-- getOtherRooms maybeRoom =
--     maybe [] Room.otherRooms maybeRoom



