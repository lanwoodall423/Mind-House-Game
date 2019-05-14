//
//  DropCommand.swift
//  StarterGame
//
//  Created by user128335 on 7/25/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class DropCommand: Command {
    override init() {
        super.init()
        self.name = "drop"
    }
    
    override func execute(_ player: Player) -> Bool{
        if hasSecondWord() {
            player.drop(itemName: secondWord!)
        } else {
            player.warningMessage("\nDrop what?")
        }
        return false
    }
}
