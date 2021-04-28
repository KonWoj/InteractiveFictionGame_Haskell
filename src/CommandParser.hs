module CommandParser where

import Command

parseCommand :: String -> Maybe Command.UserCommand
parseCommand word | word == "getInfo" = Just GetInfo
                  | otherwise = Nothing