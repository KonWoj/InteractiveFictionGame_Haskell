module Actions where
import User
import AppState
import Room
import DispatchOutput
import Data.List
import Data.Maybe
import Item

data Action = GoToRoomAction String
    | PickUpAction String
    | OpenAction String
    | ReadAction String
    | GetInfoAction

dispatch :: AppState -> Action -> DispatchOutput

dispatch AppState {user=u, rooms=rs, items=items} (GoToRoomAction newRoomName)
        | checkIfPossibleRoom newRoomName currentRoomName rs
            = successOutput AppState {user=(u {currentRoomName=newRoomName}), rooms=rs, items=items}
        | otherwise = failureOutput

  where successOutput appState
            = DispatchOutput {appState=appState, output="Jestes teraz w " ++ newRoomName ++ "\n\n" ++ itemsInRoomMsg itemsInRoom}
        failureOutput = DispatchOutput {appState=AppState {user=u, rooms=rs, items=items}, output="Nie ma takiego pokoju"}
        currentRoomName = User.currentRoomName u
        itemsInRoom = Room.getRoomItems newRoomName rs \\ User.inventory u
        itemsInRoomMsg items = "Zauważasz następujące przedmioty: " ++ ", " `intercalate` items
        checkIfPossibleRoom roomName currentRoom allRooms = roomName `elem` getOtherRooms currentRoom allRooms


dispatch AppState {user=u, rooms=rs, items=items} (PickUpAction newItem)
        | checkIfItemInInventory = itemFoundMsg
        | checkIfPossibleItem currentRoomName
            = successOutput AppState {user=(u {inventory=addItemToInventory}), rooms=rs, items=items}
        | otherwise = failureMsg

  where successOutput appState = DispatchOutput {appState=appState, output="Podniosiono " ++ newItem}
        failureMsg
            = DispatchOutput {appState=AppState {user=u, rooms=rs, items=items}, output="Nie znaleziono takiego przedmiotu"}
        itemFoundMsg
            = DispatchOutput {appState=AppState {user=u, rooms=rs, items=items}, output="Ten przedmiot zostal juz podniesiony"}
        currentRoomName = User.currentRoomName u
        checkIfPossibleItem roomName = newItem `elem` Room.getRoomItems roomName rs
        checkIfItemInInventory = newItem `elem` User.inventory u
        addItemToInventory = User.inventory u ++ [newItem]


dispatch AppState {user=u, rooms=rs, items=items} (OpenAction itemName)
        | not checkIfItemInInventory = itemNotFoundMsg
        | not checkIfItemCanBeOpened = itemCannotBeOpenedMsg
        | checkIfItemWasOpened = itemWasOpenedMsg
        | otherwise = successMsg AppState {user=(u {inventory=addInnerItemToInventory}), rooms=rs, items=items}

    where currentInventory = User.inventory u
          checkIfItemInInventory = itemName `elem` User.inventory u
          checkIfItemCanBeOpened = isJust (Item.getInnerItem itemName items)
          checkIfItemWasOpened = fromJust (Item.getInnerItem itemName items) `elem` User.inventory u
          addInnerItemToInventory = User.inventory u ++ [fromJust (Item.getInnerItem itemName items)]
          itemNotFoundMsg = DispatchOutput {appState=AppState {user=u, rooms=rs, items=items}, output="Nie znaleziono takiego przedmiotu"}
          itemCannotBeOpenedMsg = DispatchOutput {appState=AppState {user=u, rooms=rs, items=items}, output="Przedmiot nie moze zostac otwarty"}
          itemWasOpenedMsg = DispatchOutput {appState=AppState {user=u, rooms=rs, items=items}, output="Przedmiot zostal juz otwarty"}
          successMsg appState = DispatchOutput {appState=appState, output="Otwarto " ++ itemName ++ ". W srodku znajdowal sie " ++ fromJust (Item.getInnerItem itemName items)}


dispatch AppState {user=u, rooms=rs, items=items} (ReadAction itemName)
        | not checkIfItemInInventory = itemNotFoundMsg
        | otherwise = succesMsg

  where checkIfItemInInventory = itemName `elem` User.inventory u
        itemNotFoundMsg = DispatchOutput {appState=AppState {user=u, rooms=rs, items=items}, output="Nie znaleziono takiego przedmiotu"}
        succesMsg = DispatchOutput {appState=AppState {user=u, rooms=rs, items=items}, output=Item.getOnReadMsg itemName items}


getInfoAction :: AppState -> String
getInfoAction AppState {user=u, rooms=rs, items=items} = currentRoomMsg currentRoomName ++ "\n"
                                                            ++ itemsInRoomMsg itemsInRoom ++ "\n"
                                                            ++ otherRoomsMsg currentRoomName rs
                                                            ++ "\n" ++ inventoryMsg currentInventory
    where currentRoomName = User.currentRoomName u
          currentInventory = User.inventory u
          itemsInRoom = Room.getRoomItems currentRoomName rs \\ User.inventory u
          itemsInRoomMsg items = "W pokoju znajdują się następujące przedmioty: " ++ ", " `intercalate` items
          currentRoomMsg currentRoomName = "Jestes teraz w " ++ currentRoomName
          otherRoomsMsg currentRoomName allRooms = "Mozesz przejsc do " ++ (", " `intercalate` getOtherRooms currentRoomName allRooms)
          inventoryMsg inventory = "Inwentarz: " ++ (", " `intercalate` inventory)

helpAction = "Dostępne komendy:\n\
             \goToRoom [roomName] - przejdz do pokoju o nazwie roomName\n\
             \getInfo - wyswietl informacje o otoczeniu\n\
             \pickUp [itemName] - podnies przedmiot o nazwie itemName\n\
             \open [itemName] - otworz przedmiot z inwentarza o nazwie itemName"