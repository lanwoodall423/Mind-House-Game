//
//  TeleporterRoom.swift
//  StarterGame
//
//  Created by user128335 on 7/30/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

class TeleporterRoom: Room {
    func playerDidEnterTeleporter(notification: Notification) {
        let room : Room = notification.object! as! Room
        add(item: success)
    }
}
