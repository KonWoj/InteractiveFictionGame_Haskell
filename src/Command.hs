module Command where

data UserCommand = Help | GetInfo | GoToRoom {newRoomName :: String} deriving Show