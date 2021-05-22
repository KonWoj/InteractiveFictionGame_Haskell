module Item where 


data Item = Item {innerItems :: [String], onReadMsg :: String} deriving (Show)

getInnerItems :: String -> [(String, Item)] -> [String]
getInnerItems itemName itemSet = maybe [] Item.innerItems item
    where item = lookup itemName itemSet