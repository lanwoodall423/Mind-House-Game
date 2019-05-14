//
//  GiveCommand.swift
//  StarterGame
//
//  Created by user128335 on 7/25/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class GiveCommand: Command {
    
    override init() {
        super.init()
        self.name = "give"
    }
    
    override func execute(_ player: Player) -> Bool{
        if !hasSecondWord() {
            player.warningMessage("\nTo whom do you want to give something?")
        } else if !hasThirdWord(){
            player.warningMessage("\nWhat do you want to give '\(secondWord!)'?")
        } else {
            player.give(itemName : thirdWord!, toName : secondWord!)
        }
        return false
    }
}
