import System.IO

import Command
import CommandParser
import Room
import AppState
import User
import Actions
import Mapping
import DispatchOutput

livingRoom = Room {roomName="salon", otherRooms=["gabinet", "kuchnia", "lazienka"], roomObjects=[]}
office = Room {roomName="gabinet", otherRooms=["salon"], roomObjects=[]}
toilet = Room {roomName="lazienka", otherRooms=["salon"], roomObjects=[]}
kitchen = Room {roomName="kuchnia", otherRooms=["salon"], roomObjects=[]}

mapRooms = [livingRoom, office, toilet, kitchen]

userChar = UserCharacter{currentRoomName="salon"}

initialAppState = AppState {user=userChar, rooms=mapRooms}

action =  mapCommandToAction (GoToRoom {newRoomName="gabinet"})

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
                        Just comm -> do
                                        putStr (DispatchOutput.output dispatchOutput ++ "\n")
                                        game (DispatchOutput.appState dispatchOutput)
                                            where dispatchOutput = (dispatch appState (mapCommandToAction comm))
                        Nothing -> do
                                    putStr ("Niepoprawna komenda, wpisz help aby poznać poprawne komendy."++ "\n")
                                    game appState



main = do  
          game initialAppState

