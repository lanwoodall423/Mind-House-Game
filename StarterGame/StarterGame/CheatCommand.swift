//
//  CheatCommand.swift
//  StarterGame
//
//  Created by user128335 on 7/13/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class CheatCommand: Command {
    
    override init() {
        super.init()
        self.name = "cheat"
    }
    
    override func execute(_ player: Player) -> Bool {
        if !hasSecondWord(){
            let nc : NotificationCenter = NotificationCenter.default
            let n : Notification = Notification(name: Notification.Name(rawValue: "CheatNotification"), object: nil, userInfo: nil)
            nc.post(n)
        }else{
            player.warningMessage("\nI cannot cheat \(secondWord!)")
        }
        return false
    }

}
