module DispatchOutput where
import AppState

data DispatchOutput = DispatchOutput {appState :: AppState, output :: String}