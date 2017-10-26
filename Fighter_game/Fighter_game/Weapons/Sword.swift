//
//  Sword.swift
//  Fighter_game
//
//  Created by Mathieu Janneau on 26/10/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation

/**
 Warrior Weapon.
 inherits from Weapon class
 */
public class Epee: Weapon {
  init(){
    super.init(name: "Epée", damages: 10)
  }
}
