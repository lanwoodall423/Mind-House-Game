//
//  SearchCommand.swift
//  StarterGame
//
//  Created by user128335 on 7/31/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

//Search an inventory in the room
class SearchCommand: Command {
    
    override init() {
        super.init()
        self.name = "search"
    }
    
    override func execute(_ player: Player) -> Bool{
        if hasSecondWord() {
            player.search(name: secondWord!)
        } else {
            player.warningMessage("\nSearch what?")
        }
        return false
    }
}
