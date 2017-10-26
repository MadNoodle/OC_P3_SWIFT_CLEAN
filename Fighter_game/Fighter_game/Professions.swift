//
//  Warrior.swift
//  Fighter_game
//
//  Created by Mathieu Janneau on 26/10/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation

/**
 subclass of Character class that defines warrior's profession
 */
class Warrior : Character {
  init(name: String, agility: Int, force: Int ) {
    super.init(name: name,classe: "Guerrier", health: 100, maxHealth: 100,icon:"⚔", weapon: Epee(), agility: agility, force: force, intelligence: 0, wizardry: 0 )
  }
}

/**
 subclass of Character class that defines wizard's profession
 */
class Wizard : Character {
  init(name: String, intelligence: Int, wizardry: Int ) {
    super.init(name: name,classe:"Mage", health: 50, maxHealth: 50,icon:"✚", weapon: Wand() , agility: 0, force: 0, intelligence: intelligence, wizardry: wizardry )
  }
}

/**
 subclass of Character class that defines Colossus's profession
 */
class Colossus : Character {
  init(name: String, force: Int, wizardry: Int ) {
    super.init(name: name,classe:"Colosse", health: 150, maxHealth: 150,icon:"⛰", weapon: Fists() , agility: 0, force: force, intelligence: 0, wizardry: wizardry )
  }
}

/**
 subclass of Character class that defines Dwarf's profession
 */
class Dwarf : Character {
  init(name: String, agility: Int, force: Int ) {
    super.init(name: name,classe:"Nain", health: 25, maxHealth: 25,icon:"⚒", weapon: Axe() , agility: agility, force: force, intelligence: 0, wizardry: 0 )
  }
}
