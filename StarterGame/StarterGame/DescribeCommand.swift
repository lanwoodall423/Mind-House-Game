//
//  DescribeCommand.swift
//  StarterGame
//
//  Created by user128335 on 7/20/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class DescribeCommand: Command {
    override init() {
        super.init()
        self.name = "describe"
    }
    
    override func execute(_ player: Player) -> Bool{
        if hasSecondWord() {
            player.describe(itemName: secondWord!)
        } else {
            player.warningMessage("\nDescribe what?")
        }
        return false
    }
}
