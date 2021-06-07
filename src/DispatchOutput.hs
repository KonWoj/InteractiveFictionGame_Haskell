module DispatchOutput where
import AppState

{-
DisptachOutput type. Fields:
    appState :: AppState : new AppState after dispatching action
    output :: String : msg to display after dispatching action
-}
data DispatchOutput = DispatchOutput {appState :: AppState, output :: String}