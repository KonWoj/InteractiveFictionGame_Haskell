module Item where 


data Item = Item {innerItem :: Maybe String, onLick :: Maybe String, onDrink :: Maybe String, onReadMsg :: String} deriving (Show)

getInnerItem :: String -> [(String, Item)] -> Maybe String
getInnerItem itemName itemSet = maybe Nothing Item.innerItem item
    where item = lookup itemName itemSet

getOnLick :: String -> [(String, Item)] -> Maybe String
getOnLick itemName itemSet = maybe Nothing Item.onLick item
    where item = lookup itemName itemSet

getOnDrink:: String -> [(String, Item)] -> Maybe String
getOnDrink itemName itemSet = maybe Nothing Item.onDrink item
    where item = lookup itemName itemSet

getOnReadMsg :: String -> [(String, Item)] -> String
getOnReadMsg itemName itemSet = maybe "Nie ma takiego przedmiotu" Item.onReadMsg item
    where item = lookup itemName itemSet
