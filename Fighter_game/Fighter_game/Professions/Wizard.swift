//
//  Wizard.swift
//  Fighter_game
//
//  Created by Mathieu Janneau on 26/10/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation
/**
 subclass of Character class that defines wizard's profession
 */
public class Wizard : Character {
  init(name: String, intelligence: Int, wizardry: Int ) {
    super.init(name: name,classe:"Mage", health: 50, maxHealth: 50,icon:"✚", weapon: Wand() , agility: 0, force: 0, intelligence: intelligence, wizardry: wizardry )
  }
}
