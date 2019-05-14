//
//  UseCommand.swift
//  StarterGame
//
//  Created by user128335 on 7/21/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class UseCommand: Command {
    
    override init() {
        super.init()
        self.name = "use"
    }
    
    override func execute(_ player: Player) -> Bool{
        if hasSecondWord() {
            player.use(itemName: secondWord!)
        } else {
            player.warningMessage("\nUse what?")
        }
        return false
    }
}
