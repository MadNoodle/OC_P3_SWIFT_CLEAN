//
//  FrogEye.swift
//  Fighter_game
//
//  Created by Mathieu Janneau on 26/10/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation

/**
 Bonus Weapon.
 inherits from Weapon class
 */
public class FrogEye: Weapon{
  init(){
    super.init(name:"oeil de grenouille", damages: 25)
  }
}
