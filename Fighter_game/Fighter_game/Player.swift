//
//  Player.swift
//  Fighter_game
//
//  Created by Mathieu Janneau on 16/10/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation


  // ///////////////  //
  // MARK: PLAYERS //
  // ///////////////  //

class Player {
    /// Int number use to identify player
    var id : Int
    /// String Value use to identify player. Each player gives a name
    var name = ""
    var playerTeam = [Character]()
    
    
    init(id:Int){
        self.id = id
    }
    
/**
 Function that converts string input to input use to prevent crash when typing out of range input
 
 # WARNING #
 Int conversion return an optionnal DO NOT REMOVE ! !
 * ToDo:Handle the case letters are pressed
 */
  func keyInput() -> Int{
      let input = readLine();
      return Int(input!)!
  }
    
    
/**
 Function prompts user to enter his name
 */
  func playerName() {
      print("QUEL EST LE NOM DU JOUEUR \(self.id)?")
      if let playerName = readLine(){
          self.name = playerName
      }
  }
    
/**
This function is used to create a team
Here are the steps:
* Ask for player name
* Create 3 warriors and store them in playerTeam array
## Notice ##
Conditions to fullfill to create a player
* There can't be 2 warriors with the same name in the same team
* Team's count cannot exceed 3
*/
  func createPlayerTeam(){
      // ask for player to enter his name
      playerName()
    
      print("\u{001B}[0;33m \(self.name) VA COMPOSER SON EQUIPE\u{001B}[0;37m")
    
      while playerTeam.count<3{
          ///instance of a character. it has a name, a class, a weapon, a health value and damages
          let hero = createHero()

          //Name checking for duplicates
          if playerTeam.contains (where: { $0.name == hero.name }) {
              print("Ce guerrier existe déjà, Choisissez un autre nom")
          } else {
              //add hero to team
              playerTeam.append(hero)
              showTeam()
          }
          //limit team's size to 3
          if playerTeam.count == 3 {
              print("\u{001B}[0;31m⚔ ⚔ ⚔ ⚔ ⚔ ⚔ ⚔ ⚔\(self.name) EST PRET A COMBATTRE⚔ ⚔ ⚔ ⚔ ⚔ ⚔ ⚔ ⚔\u{001B}[0;37m")
          }
      }
  }

/**
This function is used to create a team. It send all the paramaters to instantiate a hero
* asks for a name
* aks for user to elect a class
*/
  func createHero() -> Character{
      ///User keyboard input
      var userChoice:Int
    
      // Give a name to a champ
      print ("\(self.name), comment s'appelle votre guerrier?")
      var name = ""
      if let nameChamp = readLine(){
          name = nameChamp
          print("Votre héros s'appelle \(nameChamp)")
      }
    
      // Choose character class
      repeat {
          print ("\n"
              + "Quelle est sa profession ?"
              + "\n1. Guerrier    ⚔    ❤️  vie: 100 pts     ⚔  Arme : Epée              🎯  Dommages: 50 pts"
              + "\n2. Mage        ✚     ❤️  vie: 50 pts      ⚔  Arme : Baguette magique  💧  Soins: 25 pts"
              + "\n3. Colosse     ⛰    ❤️  vie: 100 pts     ⚔  Arme : Poing             🎯  Dommages: 5 pts"
              + "\n4. Nain        ⚒    ❤️  vie: 25 pts      ⚔  Arme : Haches            🎯  Dommages: 30 pts"
        + "\n")
          userChoice = keyInput()
      }
      //Sanity check to prevent out of range input crash
      while userChoice != 1 && userChoice != 2 && userChoice != 3 && userChoice != 4
    
      //Classe selection
      // assuming the optionnal have a value cf. sanity check
      var classe: Classe!
      var agility = 0
      var force = 0
      var intelligence = 0
      var wizardry = 0
      switch userChoice {
      case 1:
        classe = .warrior
        repeat {
          print("Vous avez 10 points à répartir entre vos eux caracteristiques de classe"
          + "\n Combien de points voulez vous attribuez en Force?")
          force = keyInput()
          print("Combien de points voulez vous attribuez en Agilité?")
          agility = keyInput()
          intelligence = 0
          wizardry = 0
        }while (agility + force + intelligence + wizardry) != 10
      case 2:
        classe = .mage
        repeat {
        print("Vous avez 10 points à répartir entre vos eux caracteristiques de classe"
          + "\n Combien de points voulez vous attribuez en intelligence?")
          intelligence = keyInput()
          print("Combien de points voulez vous attribuez en Sorcellerie?")
          wizardry = keyInput()
          force = 0
          agility = 0
        } while (agility + force + intelligence + wizardry) != 10
      case 3:
        classe = .colossus
        repeat {
          print("Vous avez 10 points à répartir entre vos eux caracteristiques de classe"
          + "\n Combien de points voulez vous attribuez en Force?")
          force = keyInput()
          print("Combien de points voulez vous attribuez en Sorcellerie?")
          wizardry = keyInput()
          intelligence = 0
          agility = 0
          }while (agility + force + intelligence + wizardry) != 10
      case 4:
          classe = .dwarf
          repeat{
            print("Vous avez 10 points à répartir entre vos eux caracteristiques de classe"
              + "\n Combien de points voulez vous attribuez en Force?")
              agility = keyInput()
              print("Combien de points voulez vous attribuez en Agilité?")
              force = keyInput()
              intelligence = 0
              wizardry = 0
            }while (agility + force + intelligence + wizardry) != 10
      default:
        break
      }
    
    //Caracteristic attribution
      //Hero instanciantion
    let champion = Character(name:name,classe:classe, agility: agility, force: force, intelligence: intelligence, wizardry: wizardry)
    //Return Object
    return champion
  }
    
   
/**
Show Character details. There are 2 types :
* mage
* warrior

it shows the following values:
* name
* class icon
* updated health
* weapon
* damages ( linked to weapon)
*/
  func showTeamDetail (id:Int) -> String {
      ///detailed caracteristics displayed on one line
      let detail:String
    
      if playerTeam[id].classe == .mage{
          detail = "               Nom: \(playerTeam[id].name) - \(playerTeam[id].icon)    Classe : \(playerTeam[id].classe) -     ❤️  vie:  \(playerTeam[id].health) pts -    ⚔  Arme : \(playerTeam[id].weaponName) - 💧  Soins: \(playerTeam[id].weaponDmg)"
      }else{
          detail = "               Nom: \(playerTeam[id].name) - \(playerTeam[id].icon)    Classe : \(playerTeam[id].classe) -     ❤️  vie:  \(playerTeam[id].health) pts -    ⚔  Arme : \(playerTeam[id].weaponName) - 🎯 Dommages : \(playerTeam[id].weaponDmg)"}
      return detail
  }
  

    
/**
Show team composition. This display is used while player compose his team
*/
  func showTeam() {
      // Iterates throught playerTeam array to display every characters alive
      for i in 0..<playerTeam.count {
          print("\n"
              + "====Heros n°\(i+1)========================================================================================================"
                  + "\n \(showTeamDetail(id:i))"
                  + "\n====================================================================================================================="
        + "\n")
      }
  }

  

/**
Show current player team composition. This display is used while is fighting
*/
  func displayPlayerChoice(team:[Character]){
    
      for i in team {
          let index = team.index{$0 === i}!
          print(" \(index + 1 ). \(self.showTeamDetail(id:index))")
      }
  }
/**
Show current enemy team composition. This display is used while is fighting
*/
  func displayEnemyChoice(team:[Character],enemy:Player){
    
      for i in team {
          let index = team.index{$0 === i}!
          print(" \(index + 1 ). \(enemy.showTeamDetail(id:index))")
      }
  }
  
    // //////////////////////  //
    // MARK: PLAYER TURN CHOICE //
    // //////////////////////  //
    
    
/**
Contains all the mecanics in a turn
* display team
* attack or heal
### Notice ###
* if players display team a loop is called to prompt turn() again


The function takes one parameter enemyPlayer to take in consideration the two players character in attack function
*/
  func turn(enemyPlayer:Player){
      print("=====================AU TOUR DU JOUEUR \(self.id) DE JOUER====================="
          + "\n Que souhaitez vous faire?"
          + "\n1. 👁 voir l'état de votre équipe"
          + "\n2. ⚔ attaquer")
    
      if let userChoice = readLine(){
          switch userChoice {
          case "1":
              showTeam()
              turn(enemyPlayer:enemyPlayer)
          case "2":
              fight(enemyPlayer:enemyPlayer)
          default:
              print("Je ne comprends pas")
          }
      }
  }
    
    // ///////////////////  //
    // MARK: FIGHT MECANICS //
    // //////////////////  //
    
/**
Contains all the combat mecanics
* choose an fighter in your own team called attacker and store it in an Array called fighter
* attack a enemy fighter called target
* or heal a teammate to heal called target

## How the Array Fighters work ##
We store the fighter called attacker on index 0 and the target in index 1.
The function attack and heal take these objects as parameters.
### Warning ###
At the end of each action the fighter array is cleared
The function takes one parameter enemyPlayer to take in consideration the two players character in attack function
*/
    func fight(enemyPlayer:Player){
        /// Array where we store attacker and target ( will be cleared after each turn)
        var fighters = [Character]()
        
        //1ST STEP :Choose your fighter
        print("Choisissez votre attaquant")
        displayPlayerChoice(team:self.playerTeam)
        if let choice = readLine(){
            var attacker:Character
            
            switch choice {
            case "1":
                attacker = self.playerTeam[0]
                fighters.append(attacker)
           case "2":
                attacker = self.playerTeam[1]
                fighters.append(attacker)
            case "3":
                attacker = self.playerTeam[2]
                fighters.append(attacker)
            default:
                print("Je ne comprends pas")
            }
        }

        //RANDOM STEP: Random spawn a vault
        randomSpawnWeapon(hero: fighters[0])
      
        
        //STEP 2A : HEAL A TEAMMATE
        if fighters[0].classe == .mage {
            print("Choisissez la personne que vous voulez soigner")
            displayPlayerChoice(team:self.playerTeam)
            
            if let choice = readLine(){
                var target:Character
                
                switch choice {
                case "1":
                    target = self.playerTeam[0]
                    fighters.append(target)
                    target.heal(attacker:fighters[0], target:fighters[1])
                    fighters[0].characterAttackReset()
                    fighters.removeAll()
                    
                case "2":
                    target = self.playerTeam[1]
                    fighters.append(target)
                    target.heal(attacker:fighters[0], target:fighters[1])
                    fighters[0].characterAttackReset()
                    fighters.removeAll()
                case "3":
                    target = self.playerTeam[2]
                    fighters.append(target)
                    target.heal(attacker:fighters[0], target:fighters[1])
                    fighters[0].characterAttackReset()
                    fighters.removeAll()
                default:
                    print("Je ne comprends pas")
                }
                
            }
            
        }else{
            
            //STEP 2B : ATTACK AN ENEMY
            print("Choisissez votre cible")
            displayEnemyChoice(team:enemyPlayer.playerTeam, enemy: enemyPlayer)
            
            if let choice = readLine(){
                var target:Character
                
                switch choice {
                case "1":
                    target = enemyPlayer.playerTeam[0]
                    fighters.append(target)
                    target.attack(attacker:fighters[0], target:fighters[1], enemyPlayer: enemyPlayer)
                    // if damages has been changed by a class ability. We reset his damages to his weapon damages
                    fighters[0].characterAttackReset()
                    // Clear the array after fight
                    fighters.removeAll()
                  
                case "2":
                    target = enemyPlayer.playerTeam[1]
                    fighters.append(target)
                    target.attack(attacker:fighters[0], target:fighters[1], enemyPlayer: enemyPlayer)
                    fighters[0].characterAttackReset()
                    fighters.removeAll()
               
                case "3":
                    target = enemyPlayer.playerTeam[2]
                    fighters.append(target)
                    target.attack(attacker:fighters[0], target:fighters[1], enemyPlayer: enemyPlayer)
                    fighters[0].characterAttackReset()
                    fighters.removeAll()
                  
                default:
                    print("Je ne comprends pas")
                }
            }
        }
    }

    
/**
This function contains all the vault content

The content of the vault depends on the class of the attacker.
all the custom weapons are stored in an array of Weapons called bonusWeapon
* index from 0 to 3 are warrior's weapons
* index from 4 to 6 are mage's weapons
*/
    // RANDOM SPAWN WEAPON LOGIC
    func randomSpawnWeapon( hero:Character){
        ///array of bonus weapons - Might be an enum
        let bonusWeapons = [Missile(),Arc(),Baguette(), Spoon(),Powder(),FrogEye(),
            Scepter()]
        
       // pick a random number to propose a new weapon
        if hero.classe == .mage {
            ///weapons with index 4 to 6 are for mage
            let randomWeaponMage = Int(arc4random_uniform(UInt32(3) + 3))
            vaultSpawn(randomWeapon:randomWeaponMage, hero:hero, bonusWeapons:bonusWeapons)
        } else{
            ///weapons with index 0 to 3 are for others
            let randomWeapon = Int(arc4random_uniform(UInt32(3)))
            vaultSpawn(randomWeapon:randomWeapon, hero:hero, bonusWeapons:bonusWeapons)
        }
        
    }
    
  /**
   This function spaws the vault and handle the different options
   Each turn this function is called after the attacker is defined. it rolls a Interval in a range from 0 to 6. if the number is above 3 the vault spawns.
   * you can equip the weapon
   * or close the vault
   and you to the next step in turn ( STEP 2)
   */
    func vaultSpawn(randomWeapon:Int, hero:Character, bonusWeapons:[Weapon]){
    ///Pick a random number for the vault spawning
    let interval = Int(arc4random_uniform(UInt32(6)))
       
    //Random sanity check
    if interval > 3 {
        print("\u{001B}[0;32mSURPRISE !!! Un coffre apparait. Vous l'ouvrez et découvrez une \(bonusWeapons[randomWeapon].name)"
            + "\n1. Vous vous équipez avec \(bonusWeapons[randomWeapon].name)"
            + "\n2. Vous gardez votre arme\u{001B}[0;37m")
        
        //vault message + options spawning in chat
        let attacker = hero
        //User validation
        if let choice = readLine(){
            switch choice {
            case "1":
              attacker.switchWeapon(hero: attacker,classWeapon:attacker.weapon, bonusWeapon: bonusWeapons[randomWeapon])
            case "2":
                print("Je referme le coffre ")
            default:
                print("Je ne comprends pas")
            }
        }
    }

    }
   
}
