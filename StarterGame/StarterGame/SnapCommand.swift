//
//  SnapCommand.swift
//  StarterGame
//
//  Created by user128335 on 7/13/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class SnapCommand: Command {    
    override init() {
        super.init()
        self.name = "snap"
    }
    
    override func execute(_ player: Player) -> Bool {
        if !hasSecondWord() {
            player.snap()
        }else{
            player.warningMessage("\nI cannot snap \(secondWord!)")
        }
        return false
    }
}
