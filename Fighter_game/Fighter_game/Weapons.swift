//
//  Weapons.swift
//  Fighter_game
//
//  Created by Mathieu Janneau on 16/10/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation

/**
 Custom object that represent a weapon
 */

public class Weapon {
  ///amount of damages
    var damages: Int
  ///name of the weapon
    var name: String
    
    init(name: String, damages: Int){
        self.name = name
        self.damages = damages
    }
}

