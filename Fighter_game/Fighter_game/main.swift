//
//  main.swift
//  Fighter_game
//
//  Created by Mathieu Janneau on 16/10/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation


// ///////////////  //
// MARK: GAME       //
// ///////////////  //

class Game {
    var player1:Player
    var player2:Player
    
    init(player1:Player, player2:Player){
        self.player1 = player1
        self.player2 = player2
    }
    
    //Launch a new Game
    func newGame(){
        player1.createPlayerTeam()
        player2.createPlayerTeam()
        
        //TURN BY TURN LOGIC
        while player1.playerTeam.count>0 || player2.playerTeam.count>0{
            player1.turn(enemyPlayer:player2)
            player2.turn(enemyPlayer:player1)
        }
        
        //WINNING CONDITIONS
        if player1.playerTeam[0].health == 0 && player1.playerTeam[1].health == 0 && player1.playerTeam[2].health == 0 {print("\(player2.name) GAGNE")}
        else if player2.playerTeam[0].health == 0 && player2.playerTeam[1].health == 0 && player2.playerTeam[2].health == 0 {print("\(player1.name) GAGNE")}
    }
}

// ///////////////  //
// MARK: LOGIC     //
// ///////////////  //
let player1 = Player(id:1)
let player2 = Player(id:2)
let game = Game(player1:player1,player2:player2)
game.newGame()







