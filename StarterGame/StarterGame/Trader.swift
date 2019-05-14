//
//  Trader.swift
//  StarterGame
//
//  Created by user128335 on 7/30/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class Trader: NPC {
    
    
    override init(room: Room, output: GameOutput, healthPoints: Int, name: String, speech: String) {
        super.init(room: room, output: output, healthPoints: healthPoints, name: name, speech: speech)
        _name = "Trader"
        inventory = Inventory(withName: "\(_name) Inventory", andWeight: 0, andWorth: 0, andCapacity: 100, isLiftable: false)
    }
    
    func showWares() {
        npcMessage(inventory.traderWares())
    }
    
    func sell(item : String) {
        let player : Player = currentRoom.getNPC(name: "Player") as! Player
        let sellItem : ItemProtocol? = player.remove(name: item)
        if sellItem != nil {
            player.currency += sellItem!.worth
        } else {
            npcMessage("You don't have a(n) \(item)")
        }
    }
    
    func buy(item : String) {
        let player : Player = currentRoom.getNPC(name: "Player") as! Player
        let sellItem : ItemProtocol? = player.remove(name: item)
        if sellItem != nil {
            player.currency += sellItem!.worth
        } else {
            npcMessage("You don't have a(n) \(item)")
        }
    }
}
