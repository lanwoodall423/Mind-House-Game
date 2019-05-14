//
//  InventoryCommand.swift
//  StarterGame
//
//  Created by user128335 on 7/20/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class InventoryCommand: Command {
    override init() {
    super.init()
    self.name = "inventory"
    }
    
    override func execute(_ player: Player) -> Bool {
        if hasSecondWord() {
            player.warningMessage("\nSay what?")
        } else {
            player.displayInventory()
        }
        return false
    }
}
