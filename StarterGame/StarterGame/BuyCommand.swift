//
//  BuyCommand.swift
//  StarterGame
//
//  Created by user128335 on 7/31/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class BuyCommand: Command {
    
    override init() {
        super.init()
        self.name = "buy"
    }
    
    override func execute(_ player: Player) -> Bool{
        if hasSecondWord() {
            player.buy(itemName: secondWord!)
        } else {
            player.warningMessage("\nBuy what?")
        }
        return false
    }
}
