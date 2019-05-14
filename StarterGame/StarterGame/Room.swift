//
//  Room.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/16/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation

class Room: ItemStorage {
    var exits : [String : Door]
    var tag : String
    private var _delegate : RoomProtocol?
    var delegate : RoomProtocol? {
        get {
            return _delegate
        }
        set {
            _delegate = newValue
        }
    }
    private var visits: Int
    private var inventory : Inventory
    private var entityList: [String : EntityProtocol]
    
    convenience init() {
        self.init(tag: "No Tag")
    }
    
    init(tag : String) {
        exits = [String : Door]()
        self.tag = tag
        visits = 0
        inventory = Inventory(withName: "Room Inventory", andWeight: 1, andWorth: 0, andCapacity: 100, isLiftable: false)
        entityList = [String : EntityProtocol]()
    }
    
    //Exits
    func setExit(_ exitName : String, door : Door) {
        exits[exitName] = door
    }
    
    func getExit(_ exitName : String) -> Door? {
        return exits[exitName]
    }
    
    func getExits() -> String {
        let exitNames : [String] = [String](exits.keys)
        return "Exits: " + exitNames.joined(separator: " ")
    }
    
    func areAllDoorsClosed() -> Bool {
        let doors : [Door] = [Door](exits.values)
        var result : Bool = true
        for door : Door in doors{
            if door.isOpen {
                result = false
            }
        }
        return result
    }
    
    func lockdown() {
        let doors : [Door] = [Door](exits.values)
        let aLock : Lockable = RegularLock()
        for door : Door in doors{
            if door.isOpen {
                door.close()
            }
            door.installLocking(newLocking: aLock)
            door.lock()
        }
    }
    
    
    //Notifications
    func playerLeftRoom(notification : Notification) {
        incrementVisits()
    }
    
    func incrementVisits(){
        visits += 1
    }
    
    
    //Items/Inventory
    func add(item: ItemProtocol) {
        inventory.add(item: item)
    }
    
    func remove(name: String) -> ItemProtocol?{
        return inventory.remove(name: name)
    }
    
    func getItems() -> String {
        return itemsList()
    }
    
    func itemsList() -> String {
        return inventory.itemsList()
    }
    
    func description() -> String {
        let defaultDescription : String = "\n\(tag)\n\(self.getExits())\n\(self.entitiesList())\(inventory.itemsList())"
        if _delegate != nil {
            return _delegate!.description(defaultDescription: defaultDescription)
        }else{
            return defaultDescription
        }
    }
    
    
    //NPC Interaction
    func entityArrival(entity : EntityProtocol) {
        entityList[entity.name] = entity
    }
    
    func entitiesList() -> String {
        var theList : String = "Entities:"
        if entityList.isEmpty {
            theList += "\nNone."
        }
        for entity in entityList {
            if entity.key != "Player" {
                theList += "\n" + entity.key
            }
        }
        return theList
    }
    
    func getNPC(name : String) -> EntityProtocol? {
        let entity : EntityProtocol? = entityList.removeValue(forKey: name)
        if entity != nil {
            entityList[entity!.name] = entity!
        }
        return entity
    }
    
    func giveNPC(item : ItemProtocol, entity : EntityProtocol) {
        let item : ItemProtocol = item
        let entity : EntityProtocol = entity
        entity.receive(item: item)
    }
    
    func givePlayer(item : ItemProtocol) {
        let item : ItemProtocol = item
        let entity : EntityProtocol = entityList.removeValue(forKey: "Player")!
        entity.receive(item: item)
    }
    
    deinit {
        tag = ""
        exits.removeAll()
    }
}
