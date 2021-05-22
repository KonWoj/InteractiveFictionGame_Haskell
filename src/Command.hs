module Command where

data UserCommand = Help | GetInfo | GoToRoom {newRoomName :: String} | PickUp {newItem :: String} deriving Show