//
//  Dwarf.swift
//  Fighter_game
//
//  Created by Mathieu Janneau on 26/10/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation

/**
 subclass of Character class that defines Dwarf's profession
 */
public class Dwarf : Character {
  init(name: String, agility: Int, force: Int ) {
    super.init(name: name,classe:"Nain", health: 25, maxHealth: 25,icon:"⚒", weapon: Axe() , agility: agility, force: force, intelligence: 0, wizardry: 0 )
  }
}
