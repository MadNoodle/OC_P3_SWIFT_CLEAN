//
//  Fists.swift
//  Fighter_game
//
//  Created by Mathieu Janneau on 26/10/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation

/**
 Colossus Weapon.
 inherits from Weapon class
 */
public class Fists: Weapon {
  init(){
    super.init(name: "Poings", damages: 5)
  }
}
