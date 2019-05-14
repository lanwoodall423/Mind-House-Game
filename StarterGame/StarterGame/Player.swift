//
//  Player.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/16/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa
import Darwin

class Player : ItemStorage, EntityProtocol{
    var name: String
    var currentRoom : Room
    var io : GameOutput
    var inventory : Inventory
    var statuses : [String : String]
    var _currency : Int
    var currency : Int {
        get {
            return _currency
        }
        set {
            _currency = newValue
        }
    }
    
    var _healthPoints: Int
    var healthPoints: Int {
        get {
            return _healthPoints
        }
        set {
            _healthPoints = newValue
        }
    }
    
    init(room : Room, output : GameOutput) {
        name = "Player"
        currentRoom = room
        io = output
        inventory = Inventory(withName: "Player Inventory", andWeight: 1, andWorth: 0, andCapacity: 4, isLiftable: false)
        statuses = [String : String]()
        _currency = 0
        _healthPoints = 100
        room.entityArrival(entity: self)
    }
    
    //Commands
    func walkTo(_ direction : String) {
        let door : Door? = currentRoom.getExit(direction)
        if door != nil{
            if door is StatusObstacle {
                outputMessage("\nStatus Obstacle")
                let obstacle : StatusObstacle = door as! StatusObstacle
                if obstacle.statusCheck(playerStatuses: statuses) {
                    if obstacle._consumesStatus {
                        statuses = obstacle.removeStatuses(playerStatuses: statuses)
                        outputMessage("\nStatuses consumed")
                    }
                    if door!.isOpen{
                        let nextRoom : Room? = door?.otherSide(fromRoom: self.currentRoom)
                        if nextRoom != nil {
                            if nextRoom === self.currentRoom{
                                self.errorMessage("\nwhoops")
                            }
                            let nc : NotificationCenter = NotificationCenter.default
                            var n : Notification = Notification(name: Notification.Name(rawValue: "PlayerWillEnterRoom"), object: nextRoom!, userInfo: nil)
                            nc.post(n)
                            n = Notification(name: Notification.Name(rawValue: "PlayerWillExitRoom"), object: nextRoom!, userInfo: nil)
                            nc.post(n)
                            self.currentRoom = nextRoom!
                            n = Notification(name: Notification.Name(rawValue: "PlayerDidEnterRoom"), object: nextRoom!, userInfo: nil)
                            nc.post(n)
                            n = Notification(name: Notification.Name(rawValue: "PlayerDidExitRoom"), object: nextRoom!, userInfo: nil)
                            nc.post(n)
                            self.outputMessage("\n\(nextRoom!.description())")
                        } else {
                            self.errorMessage("\nThe matrix has you!")
                        }
                        if nextRoom!.tag == "Teleporter Room" {
                            let rand : UInt32 = arc4random_uniform(5)
                            
                        }
                    }else{
                        self.errorMessage("\nThe door on '\(direction)' is closed")
                    }
                } else {
                    errorMessage("\(obstacle.listRequirements())")
                }
            } else {
                if door!.isOpen{
                    let nextRoom : Room? = door?.otherSide(fromRoom: self.currentRoom)
                    if nextRoom != nil {
                        if nextRoom === self.currentRoom{
                            self.errorMessage("\nwhoops")
                        }
                        let nc : NotificationCenter = NotificationCenter.default
                        var n : Notification = Notification(name: Notification.Name(rawValue: "PlayerWillEnterRoom"), object: nextRoom!, userInfo: nil)
                        nc.post(n)
                        n = Notification(name: Notification.Name(rawValue: "PlayerWillExitRoom"), object: nextRoom!, userInfo: nil)
                        nc.post(n)
                        self.currentRoom = nextRoom!
                        n = Notification(name: Notification.Name(rawValue: "PlayerDidEnterRoom"), object: nextRoom!, userInfo: nil)
                        nc.post(n)
                        n = Notification(name: Notification.Name(rawValue: "PlayerDidExitRoom"), object: nextRoom!, userInfo: nil)
                        nc.post(n)
                        self.outputMessage("\n\(nextRoom!.description())")
                    } else {
                        self.errorMessage("\nThe matrix has you!")
                    }
                    if nextRoom!.tag == "Teleporter Room" {
                        let rand : UInt32 = arc4random_uniform(5)
                        
                    }
                }else{
                    self.errorMessage("\nThe door on '\(direction)' is closed")
                }
            }
        }
    }
    

    func inspect() {
        self.outputMessage("\n\(currentRoom.description())")
    }

    func snap() {
        if currentRoom.delegate != nil{
            currentRoom.delegate!.enabled = !currentRoom.delegate!.enabled
            inspect()
        }else{
            self.outputMessage("\nSNAP!")
        }
    }
    
    func open(exitName : String) {
        let doorToOpen: Door? = currentRoom.getExit(exitName)
        if doorToOpen != nil {
            if doorToOpen!.isOpen {
                self.warningMessage("\nThe door on '\(exitName)' is already open")
            } else {
                doorToOpen?.open()
                if doorToOpen!.isOpen{
                    self.outputMessage("\nThe door on '\(exitName)' is now open")
                } else {
                    self.errorMessage("\nThe door on '\(exitName)' did not open")
                }
            }
        } else {
            self.errorMessage("\nThere is no door on '\(exitName)'")
        }
    }
    
    func unlock(exitName : String) {
        let doorToUnlock: Door? = currentRoom.getExit(exitName)
        let key : ItemProtocol? = self.remove(name: "key")
        if (doorToUnlock?.isLocked)! {
            if key != nil {
                doorToUnlock?.locking?.unlock()
                self.outputMessage("\nThe door is now unlocked.")
            } else {
                self.warningMessage("\nYou need a key.")
            }
        } else {
            self.warningMessage("\nThe door on '\(exitName) is already unlocked")
        }
    }
    
    
    
    //Inventory Functions
    func add(item: ItemProtocol) {
        inventory.add(item: item)
    }
    
    func remove(name: String) -> ItemProtocol?{
        return inventory.remove(name: name)
    }
    
    func itemsList() -> String {
        return inventory.itemsList()
    }
    
    func extensiveItemsList() -> String {
        return inventory.extensiveItemsList()
    }
    
    
    
    //Item Commands
    func displayInventory(){
        self.outputMessage("\nCapacity: \(inventory.capacity - inventory.remainingSpace())/\(inventory.capacity)\(extensiveItemsList())")
    }
    
    func pickup(itemName : String) {
        let item : ItemProtocol? = currentRoom.remove(name: itemName)
        if item != nil {
            if (item?.liftable)! {
                if inventory.remainingSpace() >= item!.weight {
                    self.outputMessage("\n\(itemName) has been picked up.")
                    self.add(item: item!)
                } else {
                    currentRoom.add(item: item!)
                    self.errorMessage("\nYour inventory won't fit the \(itemName).")
                }
            } else {
                self.errorMessage("\nThe \(itemName) won't budge.")
            }
        } else {
            self.errorMessage("\nThere is no '\(itemName)' in the room.")
        }
    }
    
    func drop(itemName : String) {
        let item : ItemProtocol? = self.remove(name: itemName)
        if item != nil {
            self.outputMessage("\n\(itemName) has been dropped.")
            currentRoom.add(item: item!)
        } else {
            self.errorMessage("\nYou don't have an item called '\(itemName).'")
        }
    }
    
    func store(itemName : String, storageName : String) {
        let item : ItemProtocol? = self.remove(name: itemName)
        if item != nil {
            let storage : Inventory? = self.remove(name: storageName) as? Inventory
            if storage != nil {
                if storage!.remainingSpace() >= item!.weight {
                    self.outputMessage("\nYou place the \(itemName) within the \(storageName).")
                    storage?.add(item: item!)
                    inventory.add(item: storage!)
                } else {
                    self.errorMessage("\nThere's not enough space in the \(storageName).")
                    inventory.add(item: item!)
                    inventory.add(item: storage!)
                }
            } else {
                self.errorMessage("\nYou don't have an item called '\(storageName).'")
                inventory.add(item: item!)
            }
        } else {
            self.errorMessage("\nYou don't have an item called '\(itemName).'")
        }
    }
    
    func withdraw(itemName : String, fromStorage : String) {
        let storage : Inventory? = self.remove(name: fromStorage) as? Inventory
        let item : ItemProtocol? = storage?.remove(name: itemName)
        if storage != nil {
            if item != nil {
                if inventory.remainingSpace() + storage!.weight >= item!.weight {
                    self.outputMessage("\nYou take the \(itemName) from the \(fromStorage).")
                    inventory.add(item: item!)
                    inventory.add(item: storage!)
                } else {
                    self.errorMessage("\nYou don't have enough space for the \(itemName).")
                    storage!.add(item: item!)
                    inventory.add(item: storage!)
                }
            } else {
                self.errorMessage("\nYou don't have an item called \(itemName) in your \(fromStorage).")
                inventory.add(item: storage!)
            }
        } else {
            self.errorMessage("\nYou don't have a storage called \(fromStorage).")
        }
    }
    
    func search(name: String) {
        let storage : Inventory? = currentRoom.remove(name: name) as? Inventory
        if storage != nil {
            outputMessage(storage!.extensiveItemsList())
            currentRoom.add(item: storage!)
        } else {
            errorMessage("\nThere's no storage called '\(name)' in the room.")
        }
    }
    
    func loot(itemName : String, fromStorage : String) {
        let storage : Inventory? = currentRoom.remove(name: fromStorage) as? Inventory
        if storage != nil {
            let item : ItemProtocol? = storage?.remove(name: itemName)
            if item != nil {
                if inventory.remainingSpace() >= item!.weight {
                    self.outputMessage("\n\(itemName) has been looted.")
                    self.add(item: item!)
                    currentRoom.add(item: storage!)
                } else {
                    storage!.add(item: item!)
                    currentRoom.add(item: storage!)
                    self.errorMessage("\nYour inventory won't fit the \(itemName).")
                }
            } else {
                self.errorMessage("There's no item called '\(itemName)' within the \(fromStorage)")
                currentRoom.add(item: storage!)
            }
        } else {
            errorMessage("\nThere's no storage called '\(fromStorage)' in the room.")
        }
    }


    func describe(itemName : String) {
        let item : ItemProtocol? = (self.remove(name: itemName))
        if item != nil {
            self.outputMessage("\nThe item '\(itemName)' is  \(item!.description)")
            self.add(item: item!)
        } else if itemName == "self" {
            self.outputMessage("\nStatuses:")
            if statuses.isEmpty {
                self.outputMessage("\nNone.")
            }
            for status in self.statuses {
                self.outputMessage("\n'\(status.value)'")
            }
        } else {
            self.errorMessage("\nThese is no item named '\(itemName)' in the inventory.")
        }
    }
    
    func use(itemName : String) {
        let item : ItemProtocol? = self.remove(name: itemName)
        if item != nil {
            if item is StatusItem {
                if item!.name == "Machine" {
                    outputMessage("\nYou ascend from the room with seemingly impossiblly complex shapes streaking around you. You are no longer in the room. You have escaped the house.\n Congratulations!")
                }
                let statusItem : StatusItem = item! as! StatusItem
                let status : String = statusItem.use()
                statuses[status] = status
                if statusItem.multiUse {
                    self.outputMessage("\n\(itemName) is used.\nYou've gained \(status)!")
                    self.add(item: item!)
                } else {
                    outputMessage("\nYour \(itemName) is consumed\nYou've gained \(status)!")
                }
            } else {
                errorMessage("\n\(item!.name) has no inherent use.")
            }
        } else {
            self.errorMessage("\nThese is no item named '\(itemName)' in the inventory.")
        }
    }
    
    
    //Trade Commands
    func give(itemName : String, toName : String) {
        let entity : EntityProtocol? = currentRoom.getNPC(name: toName)
        if entity != nil {
            let item : ItemProtocol? = self.remove(name: itemName)
            if item != nil {
                if entity!.inventory.remainingSpace() >= item!.weight {
                    entity!.receive(item: item!)
                } else {
                    self.npcMessage("I can't fit that in my inventory!")
                    self.add(item: item!)
                }
            } else {
                self.errorMessage("\nThere is no item named '\(itemName)' in your inventory")
            }
        } else {
            self.errorMessage("\nThere's no entity called '\(toName)' here.")
        }
    }
    
    func receive(item: ItemProtocol) {
        self.add(item: item)
        self.outputMessage("\nYou received a(n) \(item.name)")
    }
    
    func speak(toWhom : String) {
        let theNPC : NPC? = currentRoom.getNPC(name: toWhom) as? NPC
        if theNPC != nil {
            theNPC!.speak(toWhom : "Player")
        } else {
            errorMessage("\nThere's no NPC here named \(toWhom)")
        }
    }
    
    func sell(itemName: String) {
        let item : ItemProtocol? = self.remove(name: itemName)
        let trader : Trader? = currentRoom.getNPC(name: "Trader") as! Trader
        if trader != nil {
            trader?.sell(item: itemName)
        } else {
            self.errorMessage("\nThere's no trader here.")
        }
    }
    

    //Messages/Output
    func outputMessage(_ message : String) {
        io.sendLine(message)
    }
    
    func outputMessage(_ message : String, color : NSColor) {
        let lastColor : NSColor = io.currentColor
        io.currentColor = color
        self.outputMessage(message)
        io.currentColor = lastColor
    }
    
    func errorMessage(_ message : String) {
        self.outputMessage(message, color: NSColor.red)
    }
    
    func warningMessage(_ message : String) {
        self.outputMessage(message, color: NSColor.orange)
    }
    
    func commandMessage(_ message : String) {
        self.outputMessage(message, color: NSColor.brown)
    }
    
    func npcMessage(_ message : String) {
        self.outputMessage("\n\(name): " + message, color : NSColor.green)
    }
}
