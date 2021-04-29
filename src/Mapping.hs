module Mapping where

import AppState
import Command
import Actions

mapCommandToAction :: UserCommand -> Action
mapCommandToAction (GoToRoom {newRoomId=rId}) = GoToRoomAction rId 

mapCommandToAction (GetInfo) = GetInfoAction