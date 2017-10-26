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
public class Warrior : Character {
  init(name: String, agility: Int, force: Int ) {
    super.init(name: name,classe: "Guerrier", health: 100, maxHealth: 100,icon:"⚔", weapon: Epee(), agility: agility, force: force, intelligence: 0, wizardry: 0 )
  }
}





