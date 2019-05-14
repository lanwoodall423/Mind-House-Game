//
//  LootCommand.swift
//  StarterGame
//
//  Created by user128335 on 7/31/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class LootCommand: Command {
    override init() {
        super.init()
        self.name = "loot"
    }
    
    override func execute(_ player: Player) -> Bool{
        if !hasSecondWord() {
            player.warningMessage("\nLoot what, from where?")
        } else if !hasThirdWord(){
            player.warningMessage("\nLoot '\(secondWord!)' from where?")
        } else {
            player.loot(itemName: secondWord!, fromStorage: thirdWord!)
        }
        return false
    }
}
