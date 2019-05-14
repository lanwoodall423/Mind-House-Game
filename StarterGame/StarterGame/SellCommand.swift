//
//  SellCommand.swift
//  StarterGame
//
//  Created by user128335 on 7/31/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class SellCommand: Command  {
    override init() {
        super.init()
        self.name = "sell"
    }
    
    override func execute(_ player: Player) -> Bool{
        if hasSecondWord() {
            player.sell(itemName: secondWord!)
        } else {
            player.warningMessage("\nSell what?")
        }
        return false
    }
}
