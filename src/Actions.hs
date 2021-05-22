module Actions where
import User
import AppState
import Room
import DispatchOutput
import Data.List

data Action = GoToRoomAction String | GetInfoAction

dispatch :: AppState -> Action -> DispatchOutput
dispatch (AppState {user=u, rooms=rs}) (GoToRoomAction newRoomName) 
        | checkIfPossibleRoom newRoomName (User.currentRoomName u) rs 
            = successOutput AppState {user=(u {currentRoomName=newRoomName}), rooms=rs} newRoomName
        | otherwise = failureOutput AppState {user=u, rooms=rs}
  where successOutput appState newRoomName = DispatchOutput {appState=appState, output="Jestes teraz w " ++ newRoomName}
        failureOutput appState = DispatchOutput {appState=appState, output="Nie ma takiego pokoju"}
        checkIfPossibleRoom roomName currentRoom allRooms = roomName `elem` (Room.roomNameToOtherRooms currentRoom allRooms)

getInfoAction :: AppState -> String
getInfoAction (AppState {user=u, rooms=rs}) = currentRoomMsg currentRoomName ++ "\n" ++ otherRoomsMsg currentRoomName rs
    where currentRoomName = (User.currentRoomName u)
          currentRoomMsg currentRoomName = "Jestes teraz w " ++ currentRoomName
          otherRoomsMsg currentRoomName allRooms = "Mozesz przejsc do " ++ (", " `intercalate` (Room.roomNameToOtherRooms currentRoomName allRooms))
          
helpAction = "Dostępne komendy:\n\
             \goToRoom [roomName] - przejdz do pokoju o nazwie roomName\n\
             \getInfo - wyswietl informacje o otoczeniu"