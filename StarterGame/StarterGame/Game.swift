//
//  Game.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/17/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation

class Game {
    var player : Player?
    var parser : Parser
    var playing : Bool
    
    init(gameIO : GameOutput) {
        //let gameWorld : GameWorld = GameWorld()
        playing = false
        parser = Parser(newCommands: CommandWords())
        player = Player(room: GameWorld.instance.createWorld(gameIO : gameIO), output: gameIO)
    }
    
    func start() {
        playing = true
        player?.outputMessage(welcome())
    }
    
    func end() {
        playing = false
        player?.outputMessage(goodbye())
    }
    
    func welcome() -> String {
        let message = "You exhale visibly once. Welcome to Mind House.\n\nType 'help' to view your capabilities"
        return "\(message)\n\n\(player!.currentRoom.description())"
    }
    
    func goodbye() -> String {
        return "\nYour mind recedes from the house. Goodbye\n"
    }
    
    func execute(_ commandString : String) -> Bool {
        var finished : Bool = false
        if playing {
            player?.commandMessage("\n>\(commandString)")
            let command : Command? = parser.parseCommand(commandString)
            if command != nil {
                finished = (command?.execute(player!))!
            } else {
                player?.errorMessage("\nI don't understand...")
            }
        }
        return finished
    }
    
    func execute(notification : Notification){
        let command : String = notification.object as! String
        execute(command)
    }
    
    
}
