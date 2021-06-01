module InitialAppState where 
import Room
import AppState ( AppState(AppState, items, rooms, user) )
import User
import Item 

livingRoom = Room {otherRooms=["gabinet", "kuchnia", "lazienka"], roomItems=["matrioszka"], roomObjects=[], onEnterMsg="Widzisz ..."}
office = Room {otherRooms=["salon"], roomObjects=[], roomItems=[], onEnterMsg="Widzisz ..."}
toilet = Room {otherRooms=["salon"], roomObjects=[], roomItems=[], onEnterMsg="Widzisz ..."}
kitchen = Room {otherRooms=["salon"], roomObjects=[], roomItems=[], onEnterMsg="Widisz ..."}

roomSet :: [(String, Room)]
roomSet = [("salon", livingRoom),
           ("gabinet", office),
           ("lazienka", toilet),
           ("kuchnia", kitchen)]

matryoshka = Item {innerItem=Just "srednia matrioszka", onLick= Just "Smakuje drewnem...", onDrink=Just "Przypominasz sobie o książce Kongres Futurologiczny", onReadMsg="Widzisz lalke matrioszke"}
mediumMatryoshka = Item {innerItem=Just "mala matrioszka", onLick=Nothing, onDrink=Nothing, onReadMsg="Widzisz sredniej wielkosci lalke matrioszke"}
smallMatryoshka = Item {innerItem=Just "bardzo mala matrioszka", onLick=Nothing, onDrink=Nothing,  onReadMsg="Widzisz mala lalke matrioszke"}
verySmallMatryoshka = Item {innerItem=Just "stary list", onLick=Nothing, onDrink=Nothing,  onReadMsg="Widzisz bardzo mala lalke matrioszke"}
oldLetter = Item {innerItem=Nothing, onLick=Nothing, onDrink=Just "Przypominasz sobie o książce Kongres Futurologiczny",  onReadMsg="Widzisz stary list z napisem: \" Jakiś napis \""}

itemSet :: [(String, Item)]
itemSet = [("matrioszka", matryoshka),
           ("srednia matrioszka", mediumMatryoshka),
           ("mala matrioszka", smallMatryoshka),
           ("bardzo mala matrioszka", verySmallMatryoshka),
           ("stary list", oldLetter)]



userChar :: UserCharacter
userChar = UserCharacter{currentRoomName="salon", inventory=[]}

initialAppState = AppState {user=userChar, rooms=roomSet, items=itemSet}