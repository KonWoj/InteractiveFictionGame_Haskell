module Command where

data UserCommand = Help | GetInfo | GoToRoom {newRoomId :: Int} deriving Show