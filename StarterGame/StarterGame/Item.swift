//
//  Item.swift
//  StarterGame
//
//  Created by user128335 on 7/20/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class Item : ItemProtocol{
    
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
    var worth: Int {
        get {
            return _worth
        }
        set {
            _worth = newValue
        }
    }
    
    var _liftable : Bool
    var liftable: Bool {
        get {
            return _liftable
        }
        set {
            _liftable = newValue
        }
    }
        
    init(withName name : String, andWeight weight : Int, andWorth worth : Int){
        _name = name
        _weight = weight
        _worth = worth
        _liftable = true
    }
    
    var description : String {
        get {
            return "A(n) \(_name) that weighs \(weight) ounce(s) and is worth \(worth) cent(s)"
        }
    }

}

//facade
func quarter() -> Item {
    return Item(withName: "quarter", andWeight: 1, andWorth: 25)
}

