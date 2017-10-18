//
//  Character.swift
//  Fighter_game
//
//  Created by Mathieu Janneau on 16/10/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation

/**
This class contains all characters caracteristics and methods
### List of methods ###
  * Attack
  * Heal
  * Die
*/

class Character {
  /// Fighter's name
  var name : String
  ///Fighter's class
  var classe : Classe  /// health points
  var health : Int
  /// maxhealth points. This parameter is used to clamp heal value to initial life
  var maxHealth : Int
  /// class icon. Each class has its own pictogram. It is displayed in Player.showDetails()
  var icon : String
  ///class weapon
  var weapon : Weapon
  /// weapon name
  var weaponName : String
  ///weapon damages
  var weaponDmg : Int
  
  var agility:Int
  var force:Int
  var intelligence:Int
  var wizardry:Int

  // Initialization function to create an instance
  init(name:String, classe:Classe, agility:Int, force: Int, intelligence:Int, wizardry:Int ){
      self.name = name
      self.classe = classe
      self.agility = agility
      self.force = force
      self.intelligence = intelligence
      self.wizardry = wizardry
    
    //CLASS CARACTERISTICS
    switch self.classe{
    case .warrior:
      self.health = 100
      self.maxHealth = 100
      self.icon = "⚔"
      self.weapon = Epee()
      self.weaponName = weapon.name
      self.weaponDmg = weapon.damages
    case .mage:
      self.health = 50
      self.maxHealth = 50
      self.icon = "✚"
      self.weapon = Wand()
      self.weaponName = weapon.name
      self.weaponDmg = weapon.damages
    case .colossus:
      self.health = 150
      self.maxHealth = 150
      self.icon = "⛰"
      self.weapon = Fists()
      self.weaponName = weapon.name
      self.weaponDmg = weapon.damages
    case .dwarf:
      self.health = 25
      self.maxHealth = 25
      self.icon = "⚒"
      self.weapon = Axe()
      self.weaponName = weapon.name
      self.weaponDmg = weapon.damages
    }

  }
  
/**
This function deals damages. It takes the value of an attacker's damage and remove the same amount of health points to the target
## Warning ##
There is a sanity check to verify if the target player is alive after dealing damages. In this case it triggers the function Die.
   
### Parameters ###
that it takes 3 parameters :
* the attacker :  a member of your team
* the target : a member of enemy team
* enemyPlayer : used to depopulate playerTeam variable when calls Die()
*/
  func attack(attacker:Character, target:Character, enemyPlayer : Player){
      //Deal Damage
      offensiveClassAbility(attacker:attacker,agility: attacker.agility, force: attacker.force, intelligence: attacker.intelligence, wizardry: attacker.wizardry )
      defensiveClassAbility(target:target, attacker:attacker, agility:target.agility, force: target.force, intelligence: target.intelligence, wizardry:target.wizardry )
      target.health -= attacker.weaponDmg
      //Check if the character dies
      if target.health <= 0 {
          //Display the message in CLI
          print ("☠️  \(target.name) est mort☠️ ☠️")
          target.die(hero:target, enemyPlayer: enemyPlayer)
      } else {
          print("\(attacker.name) fait \(attacker.weaponDmg) points de dommage à \(target.name). il lui reste \(target.health) points de vie.")
      }
  }
  
/**
This function heals a teammate. It takes the value of an attacker's damage and remove the same amount of health points to the target
## Notice ##
* There is a sanity check to verify if the target is dead or alive. Remember you cannot heal dead people.
* You can only heal a member of your own team

### Parameters ###
that it takes 2 parameters :
* the attacker :  a member of your team of the .mage classe
* the target : the member you wish to heal
*/
  func heal(attacker:Character, target:Character){
      //Check is dead or alive
      if target.health <= 0 {
          print ("☠️ On ne peut pas soigner les morts")
      } else {
          target.health += attacker.weaponDmg
          //Cannot heal more than initial health. Clamp the target life to his initial health
          if target.health > target.maxHealth {
              target.health = target.maxHealth
          }
          //Display the action in CLI
          print("\(attacker.name) soigne \(target.name) de \(attacker.weaponDmg) points de vie. \(target.name) a \(target.health) points de vie.")
      }
  }
  
/**
This function allows the character to change equip a new weapon when a vault spaws
*/
  func switchWeapon(hero: Character, classWeapon:Weapon, bonusWeapon:Weapon){
    hero.weapon = bonusWeapon
    hero.weaponDmg = bonusWeapon.damages
    if self.classe == .mage {
      print("VOUS VOUS EQUIPEZ DE \(bonusWeapon.name) ET VOUS SOIGNEZ \(bonusWeapon.damages)PTS DE VIE")
    } else{
      print("VOUS VOUS EQUIPEZ DE \(bonusWeapon.name) ET VOUS FAITES DESORMAIS \(bonusWeapon.damages)PTS DE DOMMAGE")
      
    }
  }
  
  /**
   This function destroy the hero. It looks in playerTeam array for the hero and remove him.
   
   ### Parameters ###
   that it takes 2 parameters :
   * the hero :  used to find the hero and destroy him
   * the enemyPlayer : used to fetch the enemy player's team
   */
  func die(hero:Character,enemyPlayer: Player){
      if let index = enemyPlayer.playerTeam.index(where: { $0.name == hero.name }) {
          enemyPlayer.playerTeam.remove(at: index)
      }
  }
  
  /**
   This function randomly calls a class ability to enhance attackers damages during the current turn
   */
  func offensiveClassAbility(attacker:Character,agility:Int, force: Int, intelligence:Int, wizardry:Int ){
    ///Main class caracterisitic. Acts on the odd to cast the ability and the damage algorithm
    var caracteristic1:Int
    ///Secondary class caracterisitic. Acts on the damage algorithm
    var caracteristic2:Int
    /// random number that allows us to check if the ability is casted
    var interval = 0
    
    // this defines the caracteristics by class
    switch self.classe {
    case .warrior:
      caracteristic1 = force
      caracteristic2 = agility
    case .mage:
      caracteristic1 = intelligence
      caracteristic2 = wizardry
      case .colossus:
      caracteristic1 = force
      caracteristic2 = wizardry
    case .dwarf:
      caracteristic1 = agility
      caracteristic2 = force
    }
    //Roll the dice formula to generate a random number between 0 and 20 ( 0 is the case where players puts 0 in main caracteristic)
    interval = caracteristic1 + Int(UInt32(arc4random_uniform(10)))
    
    // 11 to prevent 100% chance of casting ability
    if interval >= 11 {
      switch self.classe {
      case .warrior:
            ///critical strike damage algorithm
            let critFactor = (1 + (caracteristic2 / (1 + caracteristic1)) + caracteristic1)
            attacker.weaponDmg *= critFactor
            print("\(attacker.name) le \(attacker.classe) utilise sa compétence offensive de classe COUP CRITIQUE et inflige \(attacker.weaponDmg)")
      case .mage:
        ///critical heal damage algorithm
          let critHealFactor = (1 + (caracteristic2 / (1 + caracteristic1)) + caracteristic1)
          attacker.weaponDmg *= critHealFactor
            print("\(attacker.name) le \(attacker.classe) utilise sa compétence offensive de classe AMELIORATION et soigne \(attacker.weaponDmg)")
      case .colossus:
        /// damage of the colossus's minion
          let minionDmg = (1+(caracteristic2 / caracteristic1))
          attacker.weaponDmg *= minionDmg
            print("\(attacker.name) le \(attacker.classe) utilise sa compétence offensive de classe INVOCATION FAMILIER. Le familier mord la cible et inglige \(attacker.weaponDmg)")
      case .dwarf:
        break
      }
    }
  }
  
  /**
   This function randomly calls a class ability to enhance target damages during the current turn
   */
  func defensiveClassAbility(target:Character, attacker:Character, agility:Int, force: Int, intelligence:Int, wizardry:Int ){
    ///Main class caracterisitic. Acts on the odd to cast the ability and the damage algorithm
    var caracteristic1:Int
    ///Secondary class caracterisitic. Acts on the damage algorithm
     var caracteristic2:Int
    /// random number that allows us to check if the ability is casted
    var interval = 0
    
    // this defines the caracteristics by class
    switch self.classe {
    case .warrior:
      caracteristic1 = force
      caracteristic2 = agility
    case .mage:
      caracteristic1 = intelligence
      caracteristic2 = wizardry
    case .colossus:
      caracteristic1 = force
      caracteristic2 = wizardry
    case .dwarf:
      caracteristic1 = agility
      caracteristic2 = force
    }
    
    //Roll the dice formula to generate a random number between 0 and 20 ( 0 is the case where players puts 0 in main caracteristic)
    interval = caracteristic1 + Int(UInt32(arc4random_uniform(10)))
    
    // 11 to prevent 100% chance of casting ability
    if interval >= 11 {
      switch self.classe {
      case .warrior:
        attacker.weaponDmg = 0
        print("\(target.name) le \(target.classe) utilise sa compétence defensive de classe et BLOQUE L'ATTAQUE. Il ne reçoit pas de dégats.")
      case .mage:
        let buff = (caracteristic2 + (caracteristic1 / caracteristic2))
        target.maxHealth += buff
        print("\(target.name) le \(target.classe) utilise sa compétence defensive de classe REVIGORATION")
      case .colossus:
        let shield = (caracteristic2 + (caracteristic1 / caracteristic2))
        attacker.weaponDmg -= shield
        print("\(target.name) le \(target.classe) utilise sa compétence defensive de classe MURAILLE")
      case .dwarf:
        attacker.weaponDmg = 0
        let riposte = (1 + ((2 * caracteristic2) / (1 + caracteristic1)) + caracteristic1)
        attacker.health -= riposte
        print("\(target.name) le \(target.classe) utilise sa compétence defensive de classe PARADE RIPOSTE. Il reçoit \(attacker.weaponDmg) points de dégats. Puis il lance férocement sa hache sur \(attacker.name) et lui inflige \(riposte) points de dégats")
      }
    }
  }
/**
 Function to reset attackers damage at the end of turn. It prevents him to keep insane damages
 */
  func characterAttackReset(){
       self.weaponDmg = weapon.damages
  }
}
