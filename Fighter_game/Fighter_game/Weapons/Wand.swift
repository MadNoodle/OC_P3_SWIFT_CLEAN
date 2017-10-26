//
//  Wand.swift
//  Fighter_game
//
//  Created by Mathieu Janneau on 26/10/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation

/**
 Wizard Weapon.
 inherits from Weapon class
 */
public class Wand: Weapon {
  init(){
    super.init(name: "Baguette Magique", damages: 20)
  }
}
