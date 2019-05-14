
//
//  Ammo.swift
//  StarterGame
//
//  Created by user128335 on 7/26/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class Ammo: Ammunition {
    var _type : String
    var type : String {
        get {
            return _type
        }
        set {
            _type = newValue
        }
    }
    
    var _damage : Int
    var damage : Int {
        get {
            return _damage
        }
        set {
            _damage = newValue
        }
    }
    
    var _quantity : Int
    var quantity : Int {
        get {
            return _quantity
        }
        set {
            _quantity = newValue
        }
    }
    
    func use() {
        
    }
    
    init(type : String, damage : Int, quantity : Int) {
        _type = type
        _damage = damage
        _quantity = quantity
    }
}

func itemToAmmo(item : Item) -> Ammunition {
    return Ammo(type : item.name, damage : item.weight, quantity : 1)
}

