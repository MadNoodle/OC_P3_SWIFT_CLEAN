//
//  Weapons.swift
//  Fighter_game
//
//  Created by Mathieu Janneau on 16/10/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation

class Weapon {
    var damages:Int
    var name:String
    
    init(name:String, damages:Int){
        self.name = name
        self.damages = damages
    }
}
/**
 Warrior Weapon.
 inherits from Weapon class
 */
class Epee: Weapon {
  init(){
    super.init(name: "Epée", damages: 10)
  }
}

/**
 Wizard Weapon.
 inherits from Weapon class
 */
class Wand: Weapon {
  init(){
    super.init(name: "Baguette Magique", damages: 20)
  }
}

/**
 Colossus Weapon.
 inherits from Weapon class
 */
class Fists: Weapon {
  init(){
    super.init(name: "Poings", damages: 5)
  }
}
/**
 Dwarf Weapon.
 inherits from Weapon class
 */
class Axe: Weapon {
  init(){
    super.init(name: "Haches", damages: 30)
  }
}

/**
 Bonus Weapon.
 inherits from Weapon class
 */
class Missile: Weapon{
  init(){
    super.init(name:"Missile", damages: 100)
  }
}

/**
 Bonus Weapon.
 inherits from Weapon class
 */
class Arc: Weapon{
  init(){
    super.init(name:"Arc", damages: 35)
  }
}

/**
 Bonus Weapon.
 inherits from Weapon class
 */
class Baguette: Weapon{
  init(){
    super.init(name:"baguette de pain", damages: 5)
  }
}

/**
 Bonus Weapon.
 inherits from Weapon class
 */
class Spoon: Weapon{
  init(){
    super.init(name:"Petite cuillère", damages: 1)
  }
}

/**
 Bonus Weapon.
 inherits from Weapon class
 */
class Powder: Weapon{
  init(){
    super.init(name:"poudre magique", damages: 50)
  }
}

/**
 Bonus Weapon.
 inherits from Weapon class
 */
class FrogEye: Weapon{
  init(){
    super.init(name:"oeil de grenouille", damages: 25)
  }
}

/**
 Bonus Weapon.
 inherits from Weapon class
 */
class Scepter: Weapon{
  init(){
    super.init(name:"sceptre suerpuissant", damages: 75)
  }
}

