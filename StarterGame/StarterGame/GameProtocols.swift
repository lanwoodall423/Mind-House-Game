//
//  GameProtocols.swift
//  StarterGame
//
//  Created by user128335 on 7/13/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

protocol RoomProtocol {
    func description(defaultDescription:String) -> String
    var enabled : Bool { get set }
}

protocol Closeable {
    var isClosed : Bool { get }
    var isOpen : Bool { get }
    func close()
    func open()
}

protocol Lockable : Closeable {
    var isLocked : Bool { get }
    var isUnlocked : Bool { get }
    var shouldLock : Bool { get }
    var shouldUnlock : Bool { get }
    func lock()
    func unlock()
    var shouldClose : Bool { get }
    var shouldOpen : Bool { get }
}

protocol ItemProtocol {
    var name : String {get }
    var weight : Int { get }
    var worth : Int { get }
    var liftable : Bool { get }
    var description : String { get }
}

protocol ItemStorage {
    func add(item: ItemProtocol)
    func remove(name : String) -> ItemProtocol?
    func itemsList() -> String
}

protocol Ammunition {
    var damage : Int { get }
    var quantity : Int { get }
    func use()
}

protocol EntityProtocol {
    var name : String { get }
    var inventory : Inventory { get }
    func give(itemName : String, toName : String)
    func receive(item : ItemProtocol)
    func speak(toWhom : String)
}
