//
//  Bottle.swift
//  StarterGame
//
//  Created by user128335 on 7/30/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class Bottle: Item, ItemStorage {
    var items : [String : ItemProtocol]
    
    override init(withName name : String, andWeight weight : Int, andWorth worth : Int){
        items = [String : ItemProtocol]()
        super.init(withName: name, andWeight: weight, andWorth: worth)
    }
    
    func use() -> String {
        return ""
    }
    
    func add(item: ItemProtocol) {
        if item.name == "cloud" {
            items["cloud"] = item
        } else {
            
        }
    }
    
    func remove(name : String) -> ItemProtocol? {
        let item : ItemProtocol = Item(withName: "Blank", andWeight: 0, andWorth: 0)
        return item
    }
    
    func itemsList() -> String {
        return ""
    }
}
