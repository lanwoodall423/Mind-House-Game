//
//  LightControl.swift
//  StarterGame
//
//  Created by user128335 on 7/13/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class LightControl: RoomProtocol{
    var _enabled : Bool
    var enabled : Bool{
        get {
            return _enabled
        }
        set{
            _enabled = newValue
        }
    }
    
    init(){
        _enabled = true
    }
    
    func description(defaultDescription: String) -> String{
        if enabled {
            return "a dark room"
        }else{
            return defaultDescription
        }
    }
}
