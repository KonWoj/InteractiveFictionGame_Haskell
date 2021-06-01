module CommandParser where

import Text.Read
import Data.Maybe
import Command

import Data.Char (isSpace)

parseInteger :: String -> Maybe Int
parseInteger str  = readMaybe str

parseGoToRoomCommand :: String -> Maybe Command.UserCommand
parseGoToRoomCommand param = Just (GoToRoom {newRoomName=(trim param)})

parsePickUpCommand :: String -> Maybe Command.UserCommand 
parsePickUpCommand param = Just (PickUp {newItem=(trim param)})

parseOpenCommand :: String -> Maybe Command.UserCommand 
parseOpenCommand param = Just (Open {item=(trim param)})

parseDrinkCommand :: String -> Maybe Command.UserCommand 
parseDrinkCommand param = Just (Drink {item=(trim param)})

parseLickCommand :: String -> Maybe Command.UserCommand 
parseLickCommand param = Just (Lick {item=(trim param)})

parseReadCommand :: String -> Maybe Command.UserCommand 
parseReadCommand param = Just (Read {item=(trim param)})


parseCommandInner :: String -> String -> Maybe Command.UserCommand 
parseCommandInner x [] | x == "getInfo" = Just GetInfo
                       | x == "help" = Just Help
                       | otherwise = Nothing

parseCommandInner x (y:ys) | x == "goToRoom" = parseGoToRoomCommand (y:ys)
                           | x == "pickUp" = parsePickUpCommand (y:ys)
                           | x == "open" = parseOpenCommand (y:ys)
                           | x == "drink" = parseDrinkCommand (y:ys)
                           | x == "lick" = parseLickCommand (y:ys)
                           | x == "read" = parseReadCommand (y:ys)
                           | otherwise = parseCommandInner (x ++ [y]) ys

parseCommand :: String -> Maybe Command.UserCommand
parseCommand (x:xs) = parseCommandInner [x] xs
parseCommand _ = Nothing 

trim :: String -> String
trim = f . f
   where f = reverse . dropWhile isSpace