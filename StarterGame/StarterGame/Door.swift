//
//  Door.swift
//  StarterGame
//
//  Created by user128335 on 7/17/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class Door : Lockable {
    var roomA : Room
    var roomB : Room
    var _closed : Bool
    var locking : Lockable?
    
    init(roomA: Room, roomB: Room){
        self.roomA = roomA
        self.roomB = roomB
        _closed = false
    }
    
    func otherSide(fromRoom: Room) -> Room {
        if fromRoom === roomA{
            return roomB
        }else{
            return roomA
        }
    }
    
    func installLocking(newLocking: Lockable) {
        locking = newLocking
    }
    
    var isClosed : Bool {
        get {
            return _closed
        }
    }
    
    var isOpen : Bool {
        get {
            return !_closed
        }
    }
    
    var shouldClose : Bool {
        get {
            if locking != nil{
                return locking!.shouldClose
            } else {
                return true
            }
        }
    }
    
    var shouldOpen : Bool {
        get {
            if locking != nil {
                return locking!.shouldOpen
            } else {
                return true
            }
        }
    }
    
    func close() {
        if shouldClose{
            if locking != nil {
                if locking!.shouldClose{
                    _closed = true
                }
            } else {
                _closed = true
            }
        }
    }
    
    func open() {
        if shouldOpen{
            if locking != nil {
                if locking!.shouldOpen {
                    _closed = false
                }
            } else {
                _closed = false
            }
        }
    }
    
    var isLocked: Bool {
        get {
            if locking != nil {
                return locking!.isLocked
            } else {
                return false
            }
        }
    }
    
    var isUnlocked: Bool {
        get {
            if locking != nil {
                return locking!.isUnlocked
            } else {
                return true
            }
        }
    }
    
    var shouldLock: Bool {
        get {
            if locking != nil {
                return locking!.shouldLock
            } else {
                return true
            }
        }
    }
    
    var shouldUnlock: Bool {
        get {
            if locking != nil {
                return locking!.shouldUnlock
            } else {
                return true
            }
        }
    }
    
    func lock() {
        if locking != nil {
            locking!.lock()
        }
    }
    
    func unlock() {
        if locking != nil {
            locking!.unlock()
        }
    }
}
