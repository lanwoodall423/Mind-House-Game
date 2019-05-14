//
//  RegularLock.swift
//  StarterGame
//
//  Created by user128335 on 7/19/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class RegularLock: Lockable {
    var _locked : Bool
    
    init() {
        _locked = false
    }
    
    var isClosed: Bool {
        get {
            return false
        }
    }
    
    var isOpen : Bool {
        get {
            return false
        }
    }
    
    func close() {
        
    }
    
    func open() {
        
    }
    
    var isLocked : Bool {
        get {
            return _locked
        }
    }
    
    var isUnlocked: Bool {
        get {
            return !_locked
        }
    }
    
    var shouldLock: Bool {
        get {
            return true
        }
    }
    
    var shouldUnlock: Bool {
        get {
            return true
        }
    }
    
    func lock() {
        if shouldLock {
            _locked = true
        }
    }
    
    func unlock() {
        if shouldUnlock {
            _locked = false
        }
    }
    
    var shouldClose : Bool{
        get {
            return true
        }
    }
    
    var shouldOpen: Bool {
        get {
            return isUnlocked
        }
    }
    
}
