module Item where 


data Item = Item {innerItem :: Maybe String, onReadMsg :: String} deriving (Show)

getInnerItem :: String -> [(String, Item)] -> Maybe String
getInnerItem itemName itemSet = maybe Nothing Item.innerItem item
    where item = lookup itemName itemSet

getOnReadMsg :: String -> [(String, Item)] -> String
getOnReadMsg itemName itemSet = maybe "Nie ma takiego przedmiotu" Item.onReadMsg item
    where item = lookup itemName itemSet
