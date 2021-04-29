module CommandParser where

import Text.Read
import Data.Maybe
import Command

parseInteger :: String -> Maybe Int
parseInteger str  = readMaybe str

parseGoToRoomCommand :: String -> Maybe Command.UserCommand
parseGoToRoomCommand param = readIfNotNothing (parseInteger param)
                             where readIfNotNothing (Just roomNumber) = Just (GoToRoom {newRoomId=roomNumber})
                                   readIfNotNothing Nothing = Nothing

parseCommandInner :: String -> String -> Maybe Command.UserCommand 
parseCommandInner x [] | x == "getInfo" = Just GetInfo
                       | x == "help" = Just Help
                       | otherwise = Nothing

parseCommandInner x (y:ys) | x == "goToRoom" = parseGoToRoomCommand (y:ys)
                           | otherwise = parseCommandInner (x ++ [y]) ys

parseCommand :: String -> Maybe Command.UserCommand
parseCommand (x:xs) = parseCommandInner [x] xs