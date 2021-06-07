module InitialAppState where 
import Room
import AppState ( AppState(AppState, items, rooms, user) )
import User
import Item 

{-
All rooms instances
-}
livingRoom = Room {otherRooms=["gabinet", "kuchnia", "sypialnia", "garderoba"], roomItems=["matrioszka"]}
office = Room {otherRooms=["salon"], roomItems=["czerwona książka", "żółta książka"]}
bedroom = Room {otherRooms=["salon"], roomItems=["poduszka", "laptop"]}
kitchen = Room {otherRooms=["salon"], roomItems=["piwo", "garnek"]}
wardrobe = Room {otherRooms=["salon"], roomItems=["buty", "płaszcz"]}

{-
Room set. List of room names and coressponding room instances
-}
roomSet :: [(String, Room)]
roomSet = [("salon", livingRoom),
           ("gabinet", office),
           ("sypialnia", bedroom),
           ("kuchnia", kitchen),
           ("garderoba", wardrobe)]

{-
All items instances
-}
matryoshka = Item {
    innerItem=Just "średnia matrioszka",
    onLick= Just "Smakuje drewnem...",
    onDrink=Nothing,
    onReadMsg="Widzisz lalkę matrioszkę"
    }
mediumMatryoshka = Item {
    innerItem=Just "mała matrioszka",
    onLick=Nothing,
    onDrink=Nothing,
    onReadMsg="Widzisz średniej wielkosci lalkę matrioszkę"
    }
smallMatryoshka = Item {
    innerItem=Just "bardzo mała matrioszka",
    onLick=Nothing,
    onDrink=Nothing,
    onReadMsg="Widzisz małą lalkę matrioszkę"
    }
verySmallMatryoshka = Item {
    innerItem=Just "stary list",
    onLick=Nothing,
    onDrink=Nothing,
    onReadMsg="Widzisz bardzo małą lalkę matrioszkę"
    }

letter = Item {
    innerItem=Nothing,
    onLick=Nothing,
    onDrink=Nothing,
    onReadMsg="Musisz się obudzić samuraju!"
    }

coat = Item {
    innerItem=Just "cukierek",
    onLick=Nothing,
    onDrink=Nothing,
    onReadMsg="Ciekawy kamelowy płaszcz"
    }

candy = Item {
    innerItem=Nothing ,
    onLick= Just "Nagle się budzisz \n\n To był jakiś dziwny sen \n\n Ale dziękujemy ci za obecność \n\n A mówili, żeby nie jeść cukierków od nieznajomych\n\n",
    onDrink= Just "Przecież cukierka nie można wypić",
    onReadMsg="Jakiś dziwny cukierek"
    }

boots = Item {
    innerItem=Nothing ,
    onLick=Nothing,
    onDrink=Nothing,
    onReadMsg="Brązowe buty"
    }

beer = Item {
    innerItem=Nothing,
    onLick=Nothing,
    onDrink=Just "Nagle, w przypływie objawienia przypomina ci się film Matrix",
    onReadMsg="PIWO"
    }

pot = Item {
    innerItem=Nothing,
    onLick=Just "Metaliczny posmak",
    onDrink=Nothing,
    onReadMsg="zwykły garnek"
    }

laptop = Item {
    innerItem=Nothing,
    onLick=Just "plastikowy posmak",
    onDrink=Nothing,
    onReadMsg="na ekranie jest napisane \"sprawdź poduszkę\""
    }

cushion = Item {
    innerItem=Just "kartka",
    onLick=Nothing,
    onDrink=Nothing,
    onReadMsg="poduszka, ale chyba coś jest w środku"
    }

messageInCushion = Item {
    innerItem=Nothing,
    onLick=Nothing,
    onDrink=Nothing,
    onReadMsg="Za pazuchą!"
    }

yellowBook = Item {
    innerItem=Nothing,
    onLick=Nothing,
    onDrink=Just "Książki się czyta, a nie pije",
    onReadMsg="Podobno żółty jest kluczem do wygranej"
    }

redBook = Item {
    innerItem=Nothing,
    onLick=Nothing,
    onDrink=Nothing,
    onReadMsg="\"Kongres futurologiczny\" Stanisław Lem"
    }


{-
Item set. List of item names and coressponding item instances
-}
itemSet :: [(String, Item)]
itemSet = [("matrioszka", matryoshka),
           ("średnia matrioszka", mediumMatryoshka),
           ("mała matrioszka", smallMatryoshka),
           ("bardzo mała matrioszka", verySmallMatryoshka),
           ("płaszcz", coat),
           ("cukierek", candy),
           ("buty", boots),
           ("piwo", beer),
           ("garnek", pot),
           ("laptop", laptop),
           ("poduszka", cushion),
           ("kartka", messageInCushion),
           ("stary list", letter),
           ("żółta książka", yellowBook),
           ("czerwona książka", redBook)]


{-
UserCharacter instance with initial room and empty inventory
-}
userChar :: UserCharacter
userChar = UserCharacter{currentRoomName="salon", inventory=[]}

{-
AppState instace with initial UserCharacter instance, room set and item set
-}
initialAppState = AppState {user=userChar, rooms=roomSet, items=itemSet}