//
//  TalkToCommand.swift
//  StarterGame
//
//  Created by user128335 on 7/29/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class TalkCommand: Command {
    
    override init() {
        super.init()
        self.name = "talk"
    }
    
    override func execute(_ player: Player) -> Bool{
        if !hasSecondWord() {
            player.warningMessage("\nTo whom do you want to speak")
        } else if secondWord! == "to"{
            if hasThirdWord() {
                player.speak(toWhom : thirdWord!)
            } else {
                player.warningMessage("\nTo whom do you want to speak?")
            }
        } else {
            player.speak(toWhom: secondWord!)
        }
            return false
    }
}
