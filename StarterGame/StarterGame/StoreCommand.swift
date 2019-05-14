//
//  StoreCommand.swift
//  StarterGame
//
//  Created by user128335 on 7/29/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class StoreCommand: Command {
    
    override init() {
        super.init()
        self.name = "store"
    }
    
    override func execute(_ player: Player) -> Bool{
        if !hasSecondWord() {
            player.warningMessage("\nStore what, where?")
        } else if !hasThirdWord(){
            player.warningMessage("\nStore'\(secondWord!)' where?")
        } else {
            player.store(itemName: secondWord!, storageName: thirdWord!)
        }
        return false
    }
}
