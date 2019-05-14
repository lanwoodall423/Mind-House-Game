//
//  RemoveCommand.swift
//  StarterGame
//
//  Created by user128335 on 7/30/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class WithdrawCommand: Command {
    
    override init() {
        super.init()
        self.name = "withdraw"
    }
    
    override func execute(_ player: Player) -> Bool{
        if !hasSecondWord() {
            player.warningMessage("\nWithdraw what, from where?")
        } else if !hasThirdWord(){
            player.warningMessage("\nWithdraw '\(secondWord!)' from where?")
        } else {
            player.withdraw(itemName: secondWord!, fromStorage: thirdWord!)
        }
        return false
    }
}
