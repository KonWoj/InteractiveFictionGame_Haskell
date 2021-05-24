module Command where

data UserCommand = Help 
    | GetInfo 
    | GoToRoom {newRoomName :: String} 
    | PickUp {newItem :: String} 
    | Open {item :: String}
    | Read {item :: String}
    deriving Show