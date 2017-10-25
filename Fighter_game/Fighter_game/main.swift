//
//  main.swift
//  Fighter_game
//
//  Created by Mathieu Janneau on 16/10/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation

// ///////////////  //
// MARK: LOGIC     //
// ///////////////  //

let player1 = Player(id:1)                                      //instantiates Player 1
let player2 = Player(id:2)                                      //instantiates Player 2
var game = Game(player1:player1,player2:player2)                //instantiates the game
game.newGame()                                                  //Starts New Game







