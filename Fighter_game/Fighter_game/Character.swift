//
//  Character.swift
//  Fighter_game
//
//  Created by Mathieu Janneau on 16/10/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation



// ///////////////  //
// MARK: CHARACTERS //
// ///////////////  //

//Character object
class Character {
    let name : String // Fighter's name
    var classe : Classe //Fighter's class
    var health : Int // health points
    var icon : String // class icon
    var weapon : Weapon //class weapon
    var weaponName : String // weapon name
    var weaponDmg : Int //weapon damages
    
    init(name:String, classe : Classe){
        self.name = name
        self.classe = classe
        //class caracteristics
        switch self.classe{
        case .warrior:
            self.health = 10
            self.icon = "⚔"
            self.weapon = Weapon(name:"epee", damages: 10)
            self.weaponName = weapon.name
            self.weaponDmg = weapon.damages
        case .mage:
            self.health = 50
            self.icon = "✚"
            self.weapon = Weapon(name: "baguette magique", damages : 20)
            self.weaponName = weapon.name
            self.weaponDmg = weapon.damages
        case .colossus:
            self.health = 150
            self.icon = "⛰"
            self.weapon = Weapon(name: "poings", damages: 5)
            self.weaponName = weapon.name
            self.weaponDmg = weapon.damages
        case .dwarf:
            self.health = 25
            self.icon = "⚒"
            self.weapon = Weapon(name: "haches", damages: 30)
            self.weaponName = weapon.name
            self.weaponDmg = weapon.damages
        }
    }
}
