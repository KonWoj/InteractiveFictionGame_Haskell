import Command
import CommandParser
import Room
import AppState
import User
import Actions
import Mapping

secondRoom = Room {roomNumber=2, otherRooms=[1], roomObjects=[]}
firstRoom = Room {roomNumber=1, otherRooms=[2], roomObjects=[]}

mapRooms = [firstRoom, secondRoom]

userChar = UserCharacter{currentRoomId=1}

initialAppState = AppState {user=userChar, rooms=mapRooms}

action =  mapCommandToAction (GoToRoom {newRoomId=2})

main = print (dispatch initialAppState action)