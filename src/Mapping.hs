module Mapping where

import AppState
import Command
import Actions

mapCommandToAction :: UserCommand -> Action
mapCommandToAction (GoToRoom {newRoomName=roomName}) = GoToRoomAction roomName
mapCommandToAction (PickUp {newItem=newItem}) = PickUpAction newItem
mapCommandToAction (Open {item=item}) = OpenAction item
mapCommandToAction (Read {item=item}) = ReadAction item

mapCommandToAction (GetInfo) = GetInfoAction