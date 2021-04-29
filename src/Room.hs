module Room where

import Data.List

data RoomObject = Item | Monster deriving Show

data Room = Room {roomNumber :: Int, otherRooms :: [Int], roomObjects :: [RoomObject]} deriving Show


