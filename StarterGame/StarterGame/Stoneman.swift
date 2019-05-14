//
//  Stoneman.swift
//  StarterGame
//
//  Created by user128335 on 7/29/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class Stoneman: NPC {
    
    init(room: Room, output: GameOutput, healthPoints: Int, name: String, wantsItem: String) {
        super.init(room: room, output: output, healthPoints: 200, name: "Stoneman")
        trades = [String : ItemProtocol]()
    }
    
}
