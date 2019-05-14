//
//  PickupCommand.swift
//  StarterGame
//
//  Created by user128335 on 7/20/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class PickupCommand: Command {
    override init() {
        super.init()
        self.name = "pickup"
    }
    
    override func execute(_ player: Player) -> Bool{
        if hasSecondWord() {
            player.pickup(itemName: secondWord!)
        } else {
            player.warningMessage("\nPickup what?")
        }
        return false
    }
}
