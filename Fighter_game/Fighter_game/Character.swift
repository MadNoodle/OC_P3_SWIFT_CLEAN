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
    /**
 ToDo:Définir PV max
 */
    
    
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
    
    // ATTACK => DO DAMAGES
    func attack(attacker:Character, target:Character, enemyPlayer : Player){
        //Deal Damage
        target.health -= attacker.weaponDmg
        //Check if the character dies
        if target.health <= 0 {
            print ("☠️  \(target.name) est mort☠️ ☠️")
            
            target.die(hero:target, enemyPlayer: enemyPlayer)
            
        } else {
            print("\(attacker.name) fait \(attacker.weaponDmg) points de dommage à\(target.name). il lui reste \(target.health) points de vie.")
        }
    }
    
    //HEAL
    func heal(attacker:Character, target:Character){
        
        //Check is dead or alive
        if target.health <= 0 {
            print ("☠️ On ne peut pas soigner les morts")
        } else {
            target.health += attacker.weaponDmg
            print("\(attacker.name) soigne \(target.name) de \(attacker.weaponDmg) points de vie. \(target.name) a \(target.health) points de vie.")
        }
    }
    
    //DESTROY HERO
    func die(hero:Character,enemyPlayer: Player){
        if let index = enemyPlayer.playerTeam.index(where: { $0.name == hero.name }) {
            enemyPlayer.playerTeam.remove(at: index)
        }
    }
    
    
}
