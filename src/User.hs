module User where

data UserCharacter = UserCharacter { currentRoomName :: String, inventory :: [String]} deriving Show


addItemToInv :: String -> [String] -> Maybe [String]
addItemToInv item inv 
    | checkIfItemInInventory item inv = Nothing 
    | otherwise = Just (inv ++ [item])
  where checkIfItemInInventory itemName inv  = itemName `elem` inv