import System.IO

import Command
import CommandParser
import Room
import AppState
import User
import Actions
import Mapping



secondRoom = Room {roomNumber=2, otherRooms=[1], roomObjects=[]}
firstRoom = Room {roomNumber=1, otherRooms=[2], roomObjects=[]}

mapRooms = [firstRoom, secondRoom]

userChar = UserCharacter{currentRoomId=1}

initialAppState = AppState {user=userChar, rooms=mapRooms}

action =  mapCommandToAction (GoToRoom {newRoomId=2})

game appState = do 
                    putStr ">"
                    hFlush stdout
                    line <- getLine
                            
                    let command = (parseCommand line)
                          
                    case command of
                        Just GetInfo -> do
                                            putStr ((getInfoAction appState) ++ "\n")
                                            game appState
                        Just Help -> do
                                        putStr (helpAction ++ "\n")
                                        game appState  
                        Just comm -> game (dispatch appState (mapCommandToAction comm))
                        Nothing -> do
                                    putStr ("Niepoprawna komenda, wpisz help aby poznać poprawne komendy."++ "\n")
                                    game appState



main = do 
          game initialAppState

