module Actions where
import User
import AppState

data Action = GoToRoomAction Int | GetInfoAction

dispatch :: AppState -> Action -> AppState
dispatch (AppState {user=u, rooms=rs}) (GoToRoomAction newRoomId) = AppState {user=(u {currentRoomId=newRoomId}), rooms=rs}

getInfoAction :: AppState -> String
getInfoAction (AppState {user=u, rooms=rs}) = "You are in room number " ++ show (currentRoomId u)