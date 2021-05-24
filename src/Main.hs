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

livingRoom = Room {otherRooms=["gabinet", "kuchnia", "lazienka"], roomItems=["matrioszka"], roomObjects=[]}
office = Room {otherRooms=["salon"], roomObjects=[], roomItems=[]}
toilet = Room {otherRooms=["salon"], roomObjects=[], roomItems=[]}
kitchen = Room {otherRooms=["salon"], roomObjects=[], roomItems=[]}

roomSet :: [(String, Room)]
roomSet = [("salon", livingRoom),
           ("gabinet", office),
           ("lazienka", toilet),
           ("kuchnia", kitchen)]

matryoshka = Item {innerItem=Just "srednia matrioszka", onReadMsg="Widzisz lalke matrioszke"}
mediumMatryoshka = Item {innerItem=Just "mala matrioszka", onReadMsg="Widzisz sredniej wielkosci lalke matrioszke"}
smallMatryoshka = Item {innerItem=Just "bardzo mala matrioszka", onReadMsg="Widzisz mala lalke matrioszke"}
verySmallMatryoshka = Item {innerItem=Just "stary list", onReadMsg="Widzisz bardzo mala lalke matrioszke"}
oldLetter = Item {innerItem=Nothing, onReadMsg="Widzisz stary list z napisem: \" Jakiś napis \""}

itemSet :: [(String, Item)]
itemSet = [("matrioszka", matryoshka),
           ("srednia matrioszka", mediumMatryoshka),
           ("mala matrioszka", smallMatryoshka),
           ("bardzo mala matrioszka", verySmallMatryoshka),
           ("stary list", oldLetter)]



userChar :: UserCharacter
userChar = UserCharacter{currentRoomName="salon", inventory=[]}

initialAppState = AppState {user=userChar, rooms=roomSet, items=itemSet}

action =  mapCommandToAction (GoToRoom {newRoomName="gabinet"})

game appState = do 
                    putStr "> "
                    hFlush stdout
                    line <- getLine
                            
                    let command = (parseCommand line)
                          
                    case command of
                        Just GetInfo -> do
                                            putStr ("\n" ++ (getInfoAction appState) ++ "\n\n")
                                            game appState
                        Just Help -> do
                                        putStr ("\n" ++ helpAction ++ "\n\n")
                                        game appState  
                        Just comm -> do
                                        putStr ("\n" ++ DispatchOutput.output dispatchOutput ++ "\n\n")
                                        game (DispatchOutput.appState dispatchOutput)
                                            where dispatchOutput = (dispatch appState (mapCommandToAction comm))
                        Nothing -> do
                                    putStr ("\n" ++ "Niepoprawna komenda, wpisz help aby poznać poprawne komendy."++ "\n\n")
                                    game appState



main = do  
          game initialAppState

