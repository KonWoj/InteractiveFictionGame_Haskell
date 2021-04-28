module Command where

data UserCommand = GetInfo | GoToRoom {newRoomId :: Int} deriving Show