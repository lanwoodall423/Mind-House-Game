//
//  GameWorld.swift
//  StarterGame
//
//  Created by user128335 on 7/13/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class GameWorld {
    
    private var target : Room?
    private var from : Room?
    private var to : Room?
    private static var _instance : GameWorld = GameWorld()
    static var instance : GameWorld {
        get {
            return _instance
        }
    }
    var _entrance : Room?
    var entrance : Room {
        get {
            return _entrance!
        }
    }
    
    func createWorld(gameIO : GameOutput) -> Room {
        
        //Rooms
        let entryRoom = Room(tag: "You enter a room devoid of anyone and anything but blistering sound. You look around. Your head is pounding")
        
        let smokeyRoom = Room(tag: "As you open the door an eerie haze pours through. The smell of pine is coming from a single vertical incense burning in the middle of the room. Paranoia pervades you.")
        let wetRoom = Room(tag: "Elaborate connecting fountains are perched on the walls. Tubes coarsing with golden liquid are connected to barrels in each corner of the room.")
        let coffeeRoom = Room(tag: "The scent of coffee is in the air. You feel more awake")
        
        let powderRoom = Room(tag: "Harsh music thumps menacingly. There are white lines covering all surfaces in the room.")
        let mushRoom = Room(tag: "Luminescent mushrooms of many hues are around you. The floor is uneven. Two tall twins spin from the ground. You can eat them if you're down.")
        let dryRoom = Room(tag: "The air is hot and dry. There are overgrown cacti potted on shelves covering the walls.")

        let flowerRoom = Room(tag: "The ground is dirt brimming with purple and red flowers. Overgrown vines cover the walls with flower filled pots nestled between them.")
        let warmRoom = Room(tag: "The room is pulsing and warm. The floor is carpeted and a large cushion sits in the middle of the floor.")
        
        let tradeRoom = Room(tag: "A man with a long beard sits in the middle of this empty room with a locked chest behind him. He is a merchant.")
        
        let diamondRoom = Room(tag: "As you walk through the walkway your mind won't stay. It feels like you've been here all day. Your senses blend.")
        let ascensionRoom = Room(tag: "You enter the room. It smells like plastic. A strange feeling sinks in. Shapes of unnatural complexity appear in the corners of your vision. Everything looks purely new. ")
        let teleporterRoom = Room(tag: "The moment you enter the room your vision flashes!")
        
        let hallwayA = Room(tag: "You enter a hallway.")
        let hallwayB = Room(tag: "You enter a hallway.")
        let hallwayC = Room(tag: "You enter a hallway.")
        let hallwayA1 = Room(tag: "You enter a hallway.")
        let hallwayB1 = Room(tag: "You enter a hallway.")
        let hallwayB2 = Room(tag: "You enter a hallway.")
        let hallwayC1 = Room(tag: "You enter a hallway.")
        let hallwayC2 = Room(tag: "You enter a hallway.")
        let hallwayC3 = Room(tag: "You enter a hallway.")
        let hallwayD1 = Room(tag: "You enter a hallway.")
        let hallwayD2 = Room(tag: "You enter a hallway.")
        
        
        
        //Doors & Locks
        let aLock : Lockable = RegularLock()
        
        //entryRoom
        var door = createDoor(room1: entryRoom, room2: hallwayA, label1: "east", label2: "west")
        door = createDoor(room1: entryRoom, room2: hallwayB, label1: "west", label2: "east")
        door = createDoor(room1: entryRoom, room2: hallwayC, label1: "north", label2: "south")
        
        //smokeyRoom
        door = createDoor(room1: hallwayA, room2: smokeyRoom, label1: "east", label2: "west")
        door.installLocking(newLocking: aLock)
        door.close()
        door.lock()
        door = createDoor(room1: smokeyRoom, room2: hallwayA1, label1: "north", label2: "south")
        let waterfall = createObstacle(roomA: smokeyRoom, roomB: mushRoom, label1: "east", label2: "west", consumesStatus: false, multiRequirement: false, description: "The eastern wall is a waterfall. Its water is too menacing to pass through. You'd have to be one cold person to get through there.")
        waterfall.addStatus(status: "Stone Cold")
        
        //mushroom
        
        //dryRoom
        door = createDoor(room1: hallwayA1, room2: dryRoom, label1: "north", label2: "south")
        
        //wetRoom
        door = createDoor(room1: hallwayB, room2: wetRoom, label1: "west", label2: "east")
        door = createDoor(room1: wetRoom, room2: hallwayB1, label1: "north", label2: "south")
        door = createDoor(room1: wetRoom, room2: hallwayB2, label1: "west", label2: "east")
        
        //warmRoom
        door = createDoor(room1: hallwayB2, room2: warmRoom, label1: "west", label2: "east")
        
        //flowerRoom
        door = createDoor(room1: hallwayB1, room2: flowerRoom, label1: "north", label2: "south")
        
        //coffeeRoom
        door = createDoor(room1: hallwayC, room2: coffeeRoom, label1: "north", label2: "south")
        door = createDoor(room1: coffeeRoom, room2: hallwayC1, label1: "east", label2: "west")
        door = createDoor(room1: coffeeRoom, room2: hallwayC2, label1: "west", label2: "east")
        door = createDoor(room1: coffeeRoom, room2: hallwayC3, label1: "north", label2: "south")
        let fallenFloor = createObstacle(roomA: hallwayC, roomB: coffeeRoom, label1: "north", label2: "south", consumesStatus: true, multiRequirement: false, description: "The floor has fallen out and you can't see the bottom.")
        fallenFloor.addStatus(status: "Floating")
        
        //powderRoom
        door = createDoor(room1: hallwayC3, room2: powderRoom, label1: "north", label2: "south")
        let impossibleWay = createObstacle(roomA: powderRoom, roomB: diamondRoom, label1: "north", label2: "south", consumesStatus: false, multiRequirement: false, description: "You look ahead at an image too complex for you to understand. You can't determine its depth or mechanics. You head back. You're not weird enough to go this way.")
        impossibleWay.addStatus(status: "Weird")
        door = createDoor(room1: powderRoom, room2: hallwayD1, label1: "west", label2: "east")
        door = createDoor(room1: powderRoom, room2: hallwayD2, label1: "east", label2: "west")
        
        //tradeRoom
        door = createDoor(room1: hallwayD1, room2: tradeRoom, label1: "west", label2: "east")
        let trader : Trader = Trader(room: tradeRoom, output: gameIO, healthPoints: 10, name: "Trader", speech: "Hello traveler. Do you want money? Trade me your things for money.")
        
        //diamondRoom
        door = createDoor(room1: diamondRoom, room2: ascensionRoom, label1: "north", label2: "south")
        
        //ascensionRoom

        
        
        
        
        //Items
        //Key
        let key : ItemProtocol = Item(withName: "key", andWeight: 1, andWorth: 0)
        let gold : ItemProtocol = Item(withName: "gold", andWeight: 1, andWorth: 100)
        powderRoom.add(item: gold)
        let silver : ItemProtocol = Item(withName: "silver", andWeight: 1, andWorth: 50)
        warmRoom.add(item: silver)
        
        //NPC Desires
        let flower : ItemProtocol = Item(withName: "flower", andWeight: 1, andWorth: 0)
        flowerRoom.add(item: flower)
        let coldone : ItemProtocol = Item(withName: "coldone", andWeight: 1, andWorth: 0)
        wetRoom.add(item: coldone)
        
        //Status Items
        let coldstone : ItemProtocol = StatusItem(withName: "coldstone", andWeight: 3, andWorth: 0, givesStatus: "Stone Cold", multiUse: false)
        let incense : ItemProtocol = StatusItem(withName: "incense", andWeight: 1, andWorth: 0, givesStatus: "Floating", multiUse: true)
        smokeyRoom.add(item: incense)
        let mushroom : ItemProtocol = StatusItem(withName: "mushroom", andWeight: 1, andWorth: 0, givesStatus: "Weird", multiUse: false)
        let machine : ItemProtocol = StatusItem(withName: "Machine", andWeight: 1, andWorth: 0, givesStatus: "Winner", multiUse: false)
        ascensionRoom.add(item: machine)
        
        //Inventory Items
        let chest : Inventory = Inventory(withName: "chest", andWeight: 0, andWorth: 0, andCapacity: 10, isLiftable: false)
        chest.add(item: mushroom)
        mushRoom.add(item: chest)
        let pot : Inventory = Inventory(withName: "Pot", andWeight: 0, andWorth: 0, andCapacity: 5, isLiftable: false)
        let satchel : Inventory = Inventory(withName: "satchel", andWeight: 1, andWorth: 0, andCapacity: 6, isLiftable: true)
        pot.add(item: satchel)
        dryRoom.add(item: pot)
        
        //Weapons
        let telekinesis : Weapon = Weapon(name: "telekinesisHeadband", weight: 0, worth: 0, isLiftable: true, description : "A headband")
        
        //NPCs
        let fiend : NPC = NPC(room: hallwayA, output: gameIO, healthPoints: 10, name: "Fiend", speech: "Hey guy. Got any flowers? Come on lemme get a lil flower. I'll get you back on it.")
        fiend.addTrade(wantitem: "flower", forItem: "key")
        fiend.add(item: key)
        
        let stoneman : NPC = NPC(room: smokeyRoom, output: gameIO, healthPoints: 200, name: "Stoneman", speech: "Hey there man. Welcome, welcome. Stoneman could use a cold one to loosen up a little. I'm stone so I can't go get one. Hook me up and I'll show you how to be persistent like me.")
        stoneman.addTrade(wantitem: "coldone", forItem: "coldstone")
        stoneman.add(item: coldstone)
        
        let mushMan : NPC = NPC(room: mushRoom, output: gameIO, healthPoints: 1, name: "Mushman", speech: "Hey you, look blue. What it do? I dunno. Just go...")
        
        
        
        
        
        from = mushRoom
        to = entryRoom
        
        //entryRoom.delegate = LightControl()
        
        return entryRoom
    }
    
    func playerEnteredRoom(notification: Notification) {
        let room: Room = notification.object! as! Room
        if room === target {
            print ("I reached the target room!")
            let door : Door = Door(roomA: to!, roomB: from!)
            from!.setExit("WRAP", door: door)
            to!.setExit("WRAP", door: door)
        }
    }
    
    func playerLeftRoom(notification: Notification) {
        let room : Room = notification.object! as! Room
        room.incrementVisits()
    }
    
    func createDoor(room1: Room, room2: Room, label1: String, label2: String) -> Door {
        let door : Door = Door(roomA: room1, roomB: room2)
        room1.setExit(label1, door: door)
        room2.setExit(label2, door: door)
        return door
    }
    
    func createObstacle(roomA: Room, roomB: Room, label1 : String, label2 : String, consumesStatus : Bool, multiRequirement : Bool, description : String) -> StatusObstacle {
        let obstacle : StatusObstacle = StatusObstacle(roomA: roomA, roomB: roomB, consumesStatus : consumesStatus, multiRequirement : multiRequirement, description: description)
        roomA.setExit(label1, door: obstacle)
        roomB.setExit(label2, door: obstacle)
        return obstacle
    }
}
