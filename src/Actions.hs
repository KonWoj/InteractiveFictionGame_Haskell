module Actions where
import User
import AppState
import Room
import DispatchOutput
import Data.List
import Data.Maybe

data Action = GoToRoomAction String | PickUpAction String | GetInfoAction

dispatch :: AppState -> Action -> DispatchOutput

dispatch (AppState {user=u, rooms=rs, items=items}) (GoToRoomAction newRoomName) 
        | checkIfPossibleRoom newRoomName currentRoomName rs 
            = successOutput AppState {user=(u {currentRoomName=newRoomName}), rooms=rs, items=items} newRoomName
        | otherwise = failureOutput AppState {user=u, rooms=rs, items=items}
  where successOutput appState newRoomName = DispatchOutput {appState=appState, output="Jestes teraz w " ++ newRoomName}
        failureOutput appState = DispatchOutput {appState=appState, output="Nie ma takiego pokoju"}
        currentRoomName = User.currentRoomName u
        checkIfPossibleRoom roomName currentRoom allRooms = roomName `elem` (getOtherRooms currentRoom allRooms)


dispatch (AppState {user=u, rooms=rs, items=items}) (PickUpAction newItem)
        | checkIfItemInInventory newItem u = itemFoundOutput AppState {user=u, rooms=rs, items=items}
        | checkIfPossibleItem newItem currentRoomName rs
            = successOutput AppState {user=(u {inventory=(currentInventory ++ [newItem])}), rooms=rs, items=items} newItem
        | otherwise = failureOutput AppState {user=u, rooms=rs, items=items}
  where successOutput appState newItem = DispatchOutput {appState=appState, output="Podniosiono " ++ newItem}
        failureOutput appState = DispatchOutput {appState=appState, output="Nie znaleziono takiego przedmiotu"}
        itemFoundOutput appState = DispatchOutput {appState=appState, output="Ten przedmiot zostal juz podniesiony"}
        currentRoomName = User.currentRoomName u
        checkIfPossibleItem itemName roomName roomSet = itemName `elem` (Room.getRoomItems roomName roomSet)
        checkIfItemInInventory itemName user = itemName `elem` (User.inventory user)
        currentInventory = User.inventory u
        

getInfoAction :: AppState -> String
getInfoAction (AppState {user=u, rooms=rs}) = currentRoomMsg currentRoomName ++ "\n" 
                                              ++ otherRoomsMsg currentRoomName rs 
                                              ++ "\n" ++ inventoryMsg currentInventory
    where currentRoomName = (User.currentRoomName u)
          currentInventory = (User.inventory u) 
          currentRoomMsg currentRoomName = "Jestes teraz w " ++ currentRoomName
          otherRoomsMsg currentRoomName allRooms = "Mozesz przejsc do " ++ (", " `intercalate` (getOtherRooms currentRoomName allRooms))
          inventoryMsg inventory = "Inwentarz: " ++ (", " `intercalate` inventory)
          
helpAction = "Dostępne komendy:\n\
             \goToRoom [roomName] - przejdz do pokoju o nazwie roomName\n\
             \getInfo - wyswietl informacje o otoczeniu"