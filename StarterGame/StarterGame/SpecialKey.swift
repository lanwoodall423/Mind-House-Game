//
//  Key.swift
//  StarterGame
//
//  Created by user128335 on 7/21/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class Key: ItemProtocol {
    
    var _name : String
    var name : String {
        get {
            return _name
        }
    }
    
    var _weight : Int
    var weight : Int {
        get {
            return _weight
        }
    }
    
    var _associatedDoor : Door
    var associatedDoor : Door {
        get {
            return _associatedDoor
        }
    }
    
    init(name : String, associatedDoor : Door) {
        _name = name
        _weight = 1
        _associatedDoor = associatedDoor
    }
    
    var description : String {
        get {
            return "A \(_name) that  weighs \(_weight) ounce. It can open a locked door."
        }
    }
    
}
