//
//  Weapon.swift
//  StarterGame
//
//  Created by user128335 on 7/25/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa
import Foundation

//template method use()
class Weapon : ItemProtocol {
    
    private var _ammo : Ammunition
    
    var _name : String
    var name : String {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    
    var _weight : Int
    var weight : Int {
        get {
            return _weight
        }
        set {
            _weight = newValue
        }
    }
    
    var _worth : Int
    var worth : Int {
        get {
            return _worth
        }
        set {
            _worth = newValue
        }
    }
    
    var _liftable : Bool
    var liftable : Bool {
        get {
            return _liftable
        }
        set {
            _liftable = newValue
        }
    }
    
    var _description : String
    var description : String {
        get {
            return _description
        }
        set {
            _description = newValue
        }
    }
    
    func load(ammo : Ammunition){
        _ammo = ammo
    }
    
    func shoot() {
        
    }
    
    func use() -> String {
        return "This item is not simply used."
    }
    
    init(name : String, weight : Int, worth : Int, isLiftable : Bool, description : String) {
        _name = name
        _weight = weight
        _worth = worth
        _liftable = isLiftable
        _description = description
        _ammo = Ammo(type: "blank", damage: 0, quantity: 0)
    }

}
