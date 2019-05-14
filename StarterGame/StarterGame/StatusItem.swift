//
//  Incense.swift
//  StarterGame
//
//  Created by user128335 on 7/29/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

//Some statuses (player.status) are required to do things. Ex. Floating,
class StatusItem: Item {
    var _multiUse : Bool
    var multiUse : Bool {
        get {
            return _multiUse
        }
        set {
            _multiUse = newValue
        }
    }
    var _givesStatus : String
    var givesStatus : String {
        get {
            return _givesStatus
        }
        set {
            _givesStatus = newValue
        }
    }
    
    init(withName name: String, andWeight weight: Int, andWorth worth: Int, givesStatus : String, multiUse: Bool) {
        _givesStatus = givesStatus
        _multiUse = multiUse
        super.init(withName: name, andWeight: weight, andWorth: worth)
    }
    
    func use() -> String {
        return _givesStatus
    }
}



