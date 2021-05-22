module CommandParser where

import Text.Read
import Data.Maybe
import Command

import Data.Char (isSpace)

parseInteger :: String -> Maybe Int
parseInteger str  = readMaybe str

parseGoToRoomCommand :: String -> Maybe Command.UserCommand
parseGoToRoomCommand param = Just (GoToRoom {newRoomName=(trim param)})

parseCommandInner :: String -> String -> Maybe Command.UserCommand 
parseCommandInner x [] | x == "getInfo" = Just GetInfo
                       | x == "help" = Just Help
                       | otherwise = Nothing

parseCommandInner x (y:ys) | x == "goToRoom" = parseGoToRoomCommand (y:ys)
                           | otherwise = parseCommandInner (x ++ [y]) ys

parseCommand :: String -> Maybe Command.UserCommand
parseCommand (x:xs) = parseCommandInner [x] xs

trim :: String -> String
trim = f . f
   where f = reverse . dropWhile isSpace