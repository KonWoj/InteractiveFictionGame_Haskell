module Mapping where

import AppState
import Command
import Actions

mapCommandToAction :: UserCommand -> Action
mapCommandToAction (GoToRoom {newRoomName=roomName}) = GoToRoomAction roomName

mapCommandToAction (GetInfo) = GetInfoAction