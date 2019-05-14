//
//  StatusDoor.swift
//  StarterGame
//
//  Created by user128335 on 7/31/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

//Represents a major obstacle. Connects two areas requiring Player to have a specific status to cross.
//Ex. The floor has fallen in. Player requires status "Flying" or "Floating" to Go North
class StatusObstacle: Door {
    var requiredStatuses : [String : String]
    var _allStatusesRequired : Bool
    var _consumesStatus : Bool
    var _description : String

    
    init(roomA: Room, roomB: Room, consumesStatus : Bool, multiRequirement : Bool, description : String){
        requiredStatuses = [String : String]()
        _allStatusesRequired = multiRequirement
        _consumesStatus = consumesStatus
        _description = description
        super.init(roomA: roomA, roomB: roomB)
        _closed = false
    }
    
    func addStatus(status : String) {
        requiredStatuses[status] = status
    }
    
    func listRequirements() -> String {
        var requirements : String
        if _allStatusesRequired {
            requirements = "\n\(_description)\nPassing this obstacle requires all of the following:"
            for status in requiredStatuses {
                requirements += "\n\(status.value)"
            }
            return requirements
        } else {
            requirements = "\n\(_description)\nPassing this obstacle requires one of the following:"
            for status in requiredStatuses {
                requirements += "\n\(status.value)"
            }
            return requirements
        }
    }
    
    func statusCheck(playerStatuses : [String : String]) -> Bool {
        let playerStatuses : [String : String] = playerStatuses
        if _allStatusesRequired {
            for requiredStatus in requiredStatuses {
                if playerStatuses[requiredStatus.key] == nil {
                    return false
                }
            }
            return true
        } else {
            for requiredStatus in requiredStatuses {
                if playerStatuses[requiredStatus.key] != nil {
                    return true
                }
            }
            return false
        }
    }
    
    func removeStatuses(playerStatuses : [String : String]) -> [String : String] {
        let playerStatuses : [String : String] = playerStatuses
        var editedStatuses : [String : String] = [String : String]()
        var removed : Bool = false
        if _allStatusesRequired {
            for status in playerStatuses {
                if requiredStatuses[status.key] == nil {
                    editedStatuses[status.key] = status.value
                }
            }
            return editedStatuses
        } else {
            for status in playerStatuses {
                if requiredStatuses[status.key] == nil {
                    editedStatuses[status.key] = status.value
                } else if removed == false {
                    editedStatuses[status.key] = status.value
                    removed = true
                }
            }
            return editedStatuses
        }
    }
}
