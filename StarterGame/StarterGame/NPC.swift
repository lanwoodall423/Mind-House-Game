//
//  NPC.swift
//  StarterGame
//
//  Created by user128335 on 7/30/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class NPC: Player {
    
    var _name : String
    override var name : String {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    var _speech : String
    var speech : String {
        get {
            return _speech
        }
        set {
            _speech = newValue
        }
    }
    var trades : [String : String]
    
    
    init(room : Room, output: GameOutput, healthPoints : Int, name : String, speech : String) {
        _name = name
        _speech = speech
        trades = [String : String]()
        super.init(room: room, output: output)
        inventory = Inventory(withName: "\(_name) Inventory", andWeight: 0, andWorth: 0, andCapacity: 30, isLiftable: false)
        statuses = [String : String]()
        _healthPoints = healthPoints
        room.entityArrival(entity: self)
    }
    
    
    func addTrade(wantitem : String, forItem : String) {
        trades[wantitem] = forItem
    }
    
    override func give(itemName : String, toName : String) {
        let item : ItemProtocol? = self.remove(name: itemName)
        let entity : EntityProtocol? = currentRoom.getNPC(name: toName)
        if entity != nil {
            if item != nil {
                if entity!.inventory.remainingSpace() >= item!.weight {
                    entity!.receive(item: item!)
                } else {
                    self.npcMessage("Free up some space! I have something for you that weighs \(item!.weight) ounce(s)")
                    self.add(item: item!)
                }
            } else {
                self.errorMessage("\nI'm out of \(itemName) to give you!")
            }
        } else {
            self.errorMessage("\nWhere's the player?")
            self.add(item: item!)
        }
    }
    
    override func drop(itemName : String) {
        let item : ItemProtocol? = self.remove(name: itemName)
        if item != nil {
            self.npcMessage("\ndrops a(n) \(itemName).")
            currentRoom.add(item: item!)
        } else {
            self.errorMessage("\nOh dear. I'm out of '\(itemName).'")
        }
    }
    
    override func receive(item : ItemProtocol) {
        if trades[item.name] != nil {
            npcMessage("\nThanks for the \(item.name). Here's a(n) \(trades[item.name]!)!")
            drop(itemName: trades[item.name]!)
        } else {
            add(item: item)
            npcMessage("\nI don't want a(n) \(item.name)")
            drop(itemName: item.name)
        }
    }
    
    override func speak(toWhom : String) {
        self.npcMessage(speech)
    }
}
