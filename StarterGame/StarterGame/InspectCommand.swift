//
//  InspectCommand.swift
//  StarterGame
//
//  Created by user128335 on 7/13/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class InspectCommand: Command {
    override init() {
        super.init()
        self.name = "inspect"
    }
    
    override func execute(_ player: Player) -> Bool {
            player.inspect()
        return false
    }
}
