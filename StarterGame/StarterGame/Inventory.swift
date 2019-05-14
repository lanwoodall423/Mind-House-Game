//
//  Inventory.swift
//  StarterGame
//
//  Created by user128335 on 7/20/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class Inventory: ItemStorage, ItemProtocol {
    
    func use() -> String {
        return "wuh"
    }
    
    var items : [String : ItemProtocol]
    
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
    
    var _capacity : Int
    var capacity: Int {
        get {
            return _capacity
        }
        set {
            _capacity = newValue
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
    

    
    init(withName name : String, andWeight weight : Int, andWorth worth : Int, andCapacity capacity: Int, isLiftable : Bool) {
        items = [String : ItemProtocol]()
        _name = name
        _weight = weight
        _worth = worth
        _capacity = capacity
        _liftable = isLiftable
    }
    
    func add(item: ItemProtocol) {
        items[item.name] = item
    }

    func remove(name: String) -> ItemProtocol? {
        let item : ItemProtocol? = items.removeValue(forKey: name)
        return item
    }
    
    func itemsList() -> String {
        let itemsArray : [ItemProtocol] = [ItemProtocol](items.values)
        var fullList : String = "\n\(self.name):"
        if items.isEmpty {
            fullList += "\nEmpty"
        }
        for item in itemsArray {
            fullList += "\n" + item.description
        }
        return fullList
    }
    
    func extensiveItemsList() -> String {
        let itemsArray : [ItemProtocol] = [ItemProtocol](items.values)
        var fullList : String = "\n\(self.name):"
        if items.isEmpty {
            fullList += "\nEmpty"
        }
        for item in itemsArray {
            fullList += "\n" + item.description
            if item is Inventory{
                let inventory = item as! Inventory
                fullList += inventory.extensiveItemsList()
            }
        }
        return fullList
    }
    
    func traderWares() -> String {
        let itemsArray : [ItemProtocol] = [ItemProtocol](items.values)
        var fullList : String = "\n\(self.name):"
        if items.isEmpty {
            fullList += "\nEmpty"
        }
        for item in itemsArray {
            fullList += "\n" + item.name + " - " + "\(item.worth*2)"
            if item is Inventory{
                let inventory = item as! Inventory
                fullList += inventory.traderWares()
            }
        }
        return fullList
    }
    func remainingSpace() -> Int{
        var takenSpace : Int = 0
        for item in items {
            takenSpace += item.value.weight
        }
        return _capacity - takenSpace
    }
    
    var description : String {
        get {
            return "A(n) \(_name) that  weighs \(_weight) ounce(s). It can store up to \(capacity) ounce(s) and it's worth \(_worth) cent(s)."
        }
    }
}
