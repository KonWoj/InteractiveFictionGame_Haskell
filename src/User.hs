module User where

{-
UserCharacter type. Fields:
    currentRoomName :: String : name of current room
    inventory :: [String] : names of items in inventory
-}
data UserCharacter = UserCharacter { currentRoomName :: String, inventory :: [String]} deriving Show

{-
Add item to inventory
    first argument : item name
    second argument : current inventory

    returns : Nothing if item already in inv or Just(new list) otherwise
-}
addItemToInv :: String -> [String] -> Maybe [String]
addItemToInv item inv 
    | checkIfItemInInventory item inv = Nothing 
    | otherwise = Just (inv ++ [item])
  where checkIfItemInInventory itemName inv  = itemName `elem` inv