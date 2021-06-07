module Item where 

{-
Item type. Fields:
    innerItem :: Maybe String : Just (name of the item inside) or Nothing 
    onLick :: Maybe String : Just (msg after LickAction) or Nothing
    onDrink :: Maybe String : Just (msg after DrinkAction) or Nothing
    onReadMsg :: String : msg after ReadAction
-}
data Item = Item {innerItem :: Maybe String, onLick :: Maybe String, onDrink :: Maybe String, onReadMsg :: String} deriving (Show)

{-
Get inner item
    first argument : item name
    second argument : item set (key: item name, value: item instance)

    returns : Just(inner item name) or Nothing
-}
getInnerItem :: String -> [(String, Item)] -> Maybe String
getInnerItem itemName itemSet = maybe Nothing Item.innerItem item
    where item = lookup itemName itemSet

{-
Get on lick msg
    first argument : item name
    second argument : item set (key: item name, value: item instance)

    returns : Just(on lick msg) or Nothing
-}
getOnLick :: String -> [(String, Item)] -> Maybe String
getOnLick itemName itemSet = maybe Nothing Item.onLick item
    where item = lookup itemName itemSet

{-
Get on drink msg
    first argument : item name
    second argument : item set (key: item name, value: item instance)

    returns : Just(on dring msg) or Nothing
-}
getOnDrink:: String -> [(String, Item)] -> Maybe String
getOnDrink itemName itemSet = maybe Nothing Item.onDrink item
    where item = lookup itemName itemSet

{-
Get on read msg
    first argument : item name
    second argument : item set (key: item name, value: item instance)

    returns : on read msg
-}
getOnReadMsg :: String -> [(String, Item)] -> String
getOnReadMsg itemName itemSet = maybe "Nie ma takiego przedmiotu" Item.onReadMsg item
    where item = lookup itemName itemSet
