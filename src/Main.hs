import System.IO

import Command
import CommandParser
import Room
import AppState
import User
import Actions
import Mapping
import DispatchOutput
import Item 

livingRoom = Room {otherRooms=["gabinet", "kuchnia", "lazienka"], roomItems=["item1"], roomObjects=[]}
office = Room {otherRooms=["salon"], roomObjects=[], roomItems=[]}
toilet = Room {otherRooms=["salon"], roomObjects=[], roomItems=[]}
kitchen = Room {otherRooms=["salon"], roomObjects=[], roomItems=[]}

roomSet :: [(String, Room)]
roomSet = [("salon", livingRoom),
           ("gabinet", office),
           ("lazienka", toilet),
           ("kuchnia", kitchen)]
item1 = Item {innerItems=[], onReadMsg="Simple msg"}

itemSet :: [(String, Item)]
itemSet = [("item1", item1)]


userChar :: UserCharacter
userChar = UserCharacter{currentRoomName="salon", inventory=[]}

initialAppState = AppState {user=userChar, rooms=roomSet, items=itemSet}

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

