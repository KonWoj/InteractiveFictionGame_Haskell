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
import InitialAppState

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

