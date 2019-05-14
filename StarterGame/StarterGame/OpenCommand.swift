//
//  OpenCommand.swift
//  StarterGame
//
//  Created by user128335 on 7/18/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class OpenCommand: Command {
    override init() {
        super.init()
        self.name = "open"
    }
    
    override func execute(_ player: Player) -> Bool {
        if hasSecondWord() {
            player.open(exitName: secondWord!)
        } else {
            player.warningMessage("\nOpen what?")
        }
        return false
    }
}
