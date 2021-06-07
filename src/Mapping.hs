module Mapping where

import AppState
import Command
import Actions

{-
Mapping from UserCommand to Action
    first argument: UserCommand
    
    returns: mapped Action
-}
mapCommandToAction :: UserCommand -> Action
mapCommandToAction (GoToRoom {newRoomName=roomName}) = GoToRoomAction roomName
mapCommandToAction (PickUp {newItem=newItem}) = PickUpAction newItem
mapCommandToAction (Drink {item=item}) = DrinkAction item
mapCommandToAction (Lick {item=item}) = LickAction item
mapCommandToAction (Open {item=item}) = OpenAction item
mapCommandToAction (Read {item=item}) = ReadAction item

mapCommandToAction (GetInfo) = GetInfoAction