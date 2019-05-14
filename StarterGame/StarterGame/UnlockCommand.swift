//
//  UnlockCommand.swift
//  StarterGame
//
//  Created by user128335 on 7/21/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class UnlockCommand: Command {
    
    override init() {
        super.init()
        self.name = "unlock"
    }
    
    override func execute(_ player: Player) -> Bool{
        if hasSecondWord() {
            player.unlock(exitName: secondWord!)
        } else {
            player.warningMessage("\nUnlock which direction?")
        }
        return false
    }
}
