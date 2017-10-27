//
//  Game.swift
//  Fighter_game
//
//  Created by Mathieu Janneau on 16/10/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation


/**
 This struct contains all the Player mecanics
 ### NOTICE ###
 This struct is called by main Class and is 2nd in the control flow ( main -> Game )
 ## What does it handle ? ##
 - Instantiate Players
 - Turn by turn logic
 - Winning conditions evaluation
 */

struct Game {
  ///first player to play
  var player1:Player
  ///second player to play
  var player2:Player

  init(player1:Player, player2:Player){
      self.player1 = player1
      self.player2 = player2
  }

/**
 this function create a New Game.
 ## What is a game ? ##
 * Two players -> instances of class Player
 * play one after the other -> calls Player's function turn()
 * the game ends when all the characters of one player team are dead -> each turn we check player's team count
 * We check for winning conditions each turn calling winCheck
 */
  mutating func newGame(){
      rules()
      player1.createPlayerTeam()
      player2.createPlayerTeam()
    
      //TURN BY TURN LOGIC
      while player1.playerTeam.count>0 && player2.playerTeam.count>0 {
          // player 1 plays
          player1.turn(against:player2)
          winCheck()
          // Condition to interrupt loop if player 2 loses
          if player2.playerTeam.count>0 {
          // player 2 plays
          player2.turn(against:player1)
          winCheck()
        }
      }
  }
  
/**
Contains the winning conditions.
if a player's team array is empty the player has lost
*/
  func winCheck(){
    if player1.playerTeam.count <= 0 {print("\(player2.name) GAGNE")}
    else if player2.playerTeam.count <= 0 {print("\(player1.name) GAGNE")}
    }
  
  }

func rules(){
  print("""
=========================================================================================
|                        Bienvenue dans FIGHTER GAME                                    |
|                                                                                       |
| Dans ce jeu d'aventure en TOUR PAR TOUR, 2 Joueurs s'affrontent dans un combat à mort.|
| - Chaque joueur va composer une équipe de 3 combattants.                              |
| - L'un après l'autre, ils attaqueront leur adversaire et lui infligeront des dégats.  |
| - Le vainqueur est le premier qui tue les combattants de son adverssaire              |
|                                                                                       |
=========================================================================================

""")
}
