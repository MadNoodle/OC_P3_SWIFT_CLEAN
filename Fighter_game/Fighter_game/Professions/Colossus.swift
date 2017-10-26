//
//  Colossus.swift
//  Fighter_game
//
//  Created by Mathieu Janneau on 26/10/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation

/**
 subclass of Character class that defines Colossus's profession
 */
public class Colossus : Character {
  init(name: String, force: Int, wizardry: Int ) {
    super.init(name: name,classe:"Colosse", health: 150, maxHealth: 150,icon:"⛰", weapon: Fists() , agility: 0, force: force, intelligence: 0, wizardry: wizardry )
  }
}
