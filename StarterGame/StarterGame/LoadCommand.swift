//
//  LoadAmmoGunCommand.swift
//  StarterGame
//
//  Created by user128335 on 7/29/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class LoadCommand: Command {
    
    override init() {
        super.init()
        self.name = "Load"
    }
    
    override func execute(_ player: Player) -> Bool{
        if !hasSecondWord() {
            player.warningMessage("Load what?")
        } else if !hasThirdWord() {
            player.warningMessage("Give \(secondWord!) what?")
        } else  if hasThirdWord() {
            player.give(npc : secondWord!, item : thirdWord!)
        }
        return false
    }
}
