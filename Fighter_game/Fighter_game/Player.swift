//
//  Player.swift
//  Fighter_game
//
//  Created by Mathieu Janneau on 16/10/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation

/**
 This class contains all the Player mecanics
 ### NOTICE ###
 This class is called by Game Class and is 3rd in the control flow ( main -> Game -> Player)
 ## What does it handle ? ##
 - Keyboard Input
 - Character & team instantioation
 - UI display of team & characters Info
 - Turn options for players
 - Fight mecanics (heal & attack)
 - vault mecanics
 */
class Player {
    /// Int number use to identify player
    var id : Int
    /// String Value use to identify player. Each player gives a name
    var name = ""
    var playerTeam = [Character]()
  
    init(id: Int){
        self.id = id
    }
  
  
  // //////////////////////////// //
  // MARK : INTERACTIONS / INPUT //
  // //////////////////////////// //
  
  
/**
 Function that converts string input to input use to prevent crash when typing out of range input
 # WARNING #
 * Int conversion return an optionnal DO NOT REMOVE ! !
 * When the input is not a digit the function returns 0 so it does not fulffil the sanity check in createHero() function
*/
  public func keyInput() -> Int{
   let input = readLine()
      let number = input!
      let numberCharacters = NSCharacterSet.decimalDigits.inverted
      if number.rangeOfCharacter(from: numberCharacters) == nil {
        return Int(number)!
    } else {
        print("Veuillez entrer un chiffre")
      return 0
    }
  }

  // //////////////////////////////////////// //
  // MARK : CREATE A PLAYER CONTROL FLOW      //
  // //////////////////////////////////////// //
  
  
/**
 Function prompts user to enter his name
 */
 public func playerName() {
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
 public func createPlayerTeam(){
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
   * aks for user to select a class
   * ask the player to dispatch 10 pts in 2 class caracteritics
   */
  private func createHero() -> Character {
    ///User keyboard input
    var userChoice: Int
    /// Name given to the champ you are instantiating
    let heroName = nameChamp()
    
    repeat {
      userChoice = promptClass()
    }
      //Sanity check to prevent out of range input crash
      while userChoice != 1 && userChoice != 2 && userChoice != 3 && userChoice != 4
    
    //Classe selection - assuming the optionnal have a value cf. sanity check
    var (agility, force, intelligence, wizardry) = (0, 0, 0, 0)
   
   
    var champion: Character!
    
    switch userChoice {
    case 1:
      repeat {
        (force, agility) = caracteristicAttribution(mainCar: "FORCE", SecondaryCar: "AGILITÉ")
      }while (agility + force + intelligence + wizardry) != 10
      champion = Warrior(name:heroName,agility:agility,force:force)
  
    case 2:
      repeat {
        (intelligence,wizardry) = caracteristicAttribution(mainCar: "INTELLIGENCE", SecondaryCar: "SORCELLERIE")
      } while (agility + force + intelligence + wizardry) != 10
      champion = Wizard(name:heroName,intelligence:intelligence,wizardry:wizardry)
     
    case 3:
      repeat {
        (force,wizardry) = caracteristicAttribution(mainCar: "FORCE", SecondaryCar: "WIZARDRY")
      }while (agility + force + intelligence + wizardry) != 10
     champion = Colossus(name:heroName,force:force,wizardry:wizardry)
 
    case 4:
      repeat{
        (agility,force) = caracteristicAttribution(mainCar: "AGILITÉ", SecondaryCar: "FORCE")
      }while (agility + force + intelligence + wizardry) != 10
      champion = Dwarf(name:heroName,agility:agility,force:force)
   
    default:
      break
      }
    
   return champion
  }
  
  
  // ///////////////////////////////// //
  // MARK : INTANTIATION FUNCTIONS     //
  // ///////////////////////////////// //
  
  /**
   This function asks the user to give a name to his champion
   */
  func nameChamp() -> String {
    print ("\(self.name), comment s'appelle votre guerrier?")
    var name = ""
    
    if let nameChamp = readLine(){
      name = nameChamp
      print("Votre héros s'appelle \(nameChamp)")
    }
    return name
  }
  
  /**
   This function allows the user to dispatch the 10 class points in the 2 class caracteristics.
   ## Warning ##
   If the sum of the 2 Input differs from 10 the user will have to dispatch the points
   - parameters:
   - mainCar : main caracteristic of the Hero
   - SecondaryCar : secondary caracteristic of the hero
   */
  func caracteristicAttribution(mainCar: String, SecondaryCar: String) -> (Int, Int){
    print("Vous avez 10 points à répartir entre vos deux caracteristiques de classe (\(mainCar) &  \(SecondaryCar))"
      + "\n Combien de points voulez vous attribuez en \(mainCar)?")
    let carcateristicMain = keyInput()
    print("Combien de points voulez vous attribuez en \(SecondaryCar)?")
    let caracteristicSecondary = keyInput()
    return (carcateristicMain, caracteristicSecondary)
  }
 
/**
 This function propose the user to choose between 4 classes of character
 - Return: int
 */
  private func promptClass() -> Int{
    // Choose character class
    
    print ("\n"
      + "Quelle est sa profession ?"
      + "\n1. Guerrier    ⚔    ❤️  vie: 100 pts     ⚔  Arme : Epée              🎯  Dommages: 50 pts"
      + "\n2. Mage        ✚     ❤️  vie: 50 pts      ⚔  Arme : Baguette magique  💧  Soins: 25 pts"
      + "\n3. Colosse     ⛰    ❤️  vie: 100 pts     ⚔  Arme : Poing             🎯  Dommages: 5 pts"
      + "\n4. Nain        ⚒    ❤️  vie: 25 pts      ⚔  Arme : Haches            🎯  Dommages: 30 pts"
      + "\n")
    let userChoice = keyInput()
    return userChoice
  }
  
  // //////////////////////////// //
  // MARK : UI FUNCTIONS             //
  // //////////////////////////// //
/**
Show Character details. There are 2 types :
* mage
* others

it shows the following values:
* name
* class icon
* updated health
* weapon
* damages ( linked to weapon)
   
 - Parameters:
   - id: index of hero in playerTeam array
   
 - Return: String
*/
  private func showTeamDetail (id: Int) -> String {
      ///detailed caracteristics displayed on one line
      let detail: String
    
      if playerTeam[id].classe == "Mage"{
          detail = "               Nom: \(playerTeam[id].name) - \(playerTeam[id].icon)    Classe : \(playerTeam[id].classe) -     ❤️  vie:  \(playerTeam[id].health) pts -    ⚔  Arme : \(playerTeam[id].weapon.name) - 💧  Soins: \(playerTeam[id].weapon.damages)"
      }else{
          detail = "               Nom: \(playerTeam[id].name) - \(playerTeam[id].icon)    Classe : \(playerTeam[id].classe) -     ❤️  vie:  \(playerTeam[id].health) pts -    ⚔  Arme : \(playerTeam[id].weapon.name) - 🎯 Dommages : \(playerTeam[id].weapon.damages)"}
      return detail
  }
  
/**
Show team composition. This display is used while player compose his team
*/
  private func showTeam() {
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
   
 - Parameters:
   - team: Array of character
*/
  private func displayPlayerChoice(of team: [Character]){
    
      for i in team {
          let index = team.index{$0 === i}!
          print(" \(index + 1 ). \(self.showTeamDetail(id:index))")
      }
  }
  
/**
Show current enemy team composition. This display is used while is fighting
 - Parameters:
   - team: Array of character
   - enemy: opposite player
*/
  private func displayEnemyChoice(team: [Character], enemy: Player){
    
      for i in team {
          let index = team.index{$0 === i}!
          print(" \(index + 1 ). \(enemy.showTeamDetail(id: index))")
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
 - Parameters:
   - enemyPlayer: opposite player
*/
 internal func turn(against enemyPlayer: Player){
      print("=====================AU TOUR DU JOUEUR \(self.id) DE JOUER====================="
          + "\n Que souhaitez vous faire?"
          + "\n1. 👁 voir l'état de votre équipe"
          + "\n2. ⚔ attaquer")
    
      if let userChoice = readLine(){
          switch userChoice {
          case "1":
              showTeam()
              turn(against: enemyPlayer)
          case "2":
              fight(against: enemyPlayer)
          default:
              print("Je ne comprends pas")
          }
      }
  }
    
    // ///////////////////  //
    // MARK: FIGHTER SELECTION //
    // //////////////////  //
    
 public func chooseFighter(_ fighters: inout [Character]) {
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
  }
  
  /**
   This function contains the process to target an enemy player and attack him. it selects a character and push it in the fighter array index 1.
   Then it calls the Character function attack
   Then reset attackers damages in case of class ability execution
   then it clears the fighter array
   - Parameters:
   - enemyPlayer: currently attacked player
   - fighters: array that contains the two opponent of the figth
   - id: index of the target character in the playerTeam array
   */
  internal func targetEnemy(enemyPlayer: Player, fighters: [Character], id: Int){
    var fighters = fighters
    let target = enemyPlayer.playerTeam[id]
    fighters.append(target)
    target.attack(from: fighters[0], on: fighters[1], partOf: enemyPlayer)
    // if damages has been changed by a class ability. We reset his damages to his weapon damages
    fighters[0].characterAttackReset()
    // Clear the array after fight
    fighters.removeAll()
  }
  
  /**
   This function contains the process to heal a teammate. it selects a character and push it in the fighter array index 1.
   Then it calls the Character function heal
   Then reset attackers heal value in case of class ability execution
   then it clears the fighter array
   - Parameters:
   - fighters: array that contains the two opponent of the figth
   - id: index of the target character in the playerTeam array
   */
  internal func targetTeammate(fighters: [Character], id: Int){
    var fighters = fighters
    let target = self.playerTeam[id]
    fighters.append(target)
    target.heal(from: fighters[0], on: fighters[1])
    // if heal has been changed by a class ability. We reset his heal to his weapon damages
    fighters[0].characterAttackReset()
    // Clear the array after fight
    fighters.removeAll()
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
 - Parameters:
   - enemyPlayer: opposite player
*/
 private func fight(against enemyPlayer:Player){
      /// Array where we store attacker and target ( will be cleared after each turn)
      var fighters = [Character]()
  
  //1ST STEP :Choose your fighter
      print("Choisissez votre attaquant")
      displayPlayerChoice(of: self.playerTeam)
      chooseFighter(&fighters)
  
  //RANDOM STEP: Random spawn a vault
      randomSpawnWeapon(for: fighters[0])
  
  //STEP 2A : HEAL A TEAMMATE
      if fighters[0].classe == "Mage"{
          print("Choisissez la personne que vous voulez soigner")
          displayPlayerChoice(of: self.playerTeam)
          healTarget(&fighters)
      }else{
  //STEP 2B : ATTACK AN ENEMY
          print("Choisissez votre cible")
          displayEnemyChoice(team: enemyPlayer.playerTeam, enemy: enemyPlayer)
        
          if let choice = readLine(){
              switch choice {
              case "1":
                targetEnemy(enemyPlayer: enemyPlayer, fighters: fighters, id : 0)
              case "2":
                 targetEnemy(enemyPlayer: enemyPlayer, fighters: fighters, id : 1)
              case "3":
                  targetEnemy(enemyPlayer: enemyPlayer, fighters: fighters, id : 2)
              default:
                  print("Je ne comprends pas")
              }
          }
      }
  }
  
  
  /**
   This function contains the process to target a teammate and heal him.
   it offers the possibility to the player to select a teammate and heal him
   - Parameters:
   - fighters: array that contains the two opponent of the figth
   */
  internal func healTarget(_ fighters: inout [Character]) {
    if let choice = readLine(){
      switch choice {
      case "1":
        targetTeammate(fighters: fighters, id :0)
      case "2":
        targetTeammate(fighters: fighters, id :1)
      case "3":
        targetTeammate(fighters: fighters, id :2)
      default:
        print("Je ne comprends pas")
      }
      
    }
  }

  
  // ///////////////////  //
  // MARK: VAULT MECANICS //
  // //////////////////  //
  
  
/**
This function contains all the vault content

The content of the vault depends on the class of the attacker.
all the custom weapons are stored in an array of Weapons called bonusWeapon
* index from 0 to 3 are warrior's weapons
* index from 4 to 6 are mage's weapons
 - Parameters:
   - hero: currently attacking Character
*/
  private func randomSpawnWeapon(for hero: Character){
      ///array of bonus weapons - Might be an enum
      let bonusWeapons = [Missile(),Arc(),Baguette(), Spoon(),Powder(),FrogEye(),
          Scepter()]
    
     // pick a random number to propose a new weapon
      if hero.classe == "Mage" {
          ///weapons with index 4 to 6 are for mage
          let randomWeaponMage = Int(arc4random_uniform(UInt32(3) + 3))
          vaultSpawn(randomWeapon: randomWeaponMage, hero: hero, bonusWeapons: bonusWeapons)
      } else{
          ///weapons with index 0 to 3 are for others
          let randomWeapon = Int(arc4random_uniform(UInt32(3)))
          vaultSpawn(randomWeapon: randomWeapon, hero: hero, bonusWeapons: bonusWeapons)
      }
    
  }
    
/**
 This function spaws the vault and handle the different options
 Each turn this function is called after the attacker is defined. it rolls a Interval in a range from 0 to 6. if the number is above 3 the vault spawns.
 * you can equip the weapon
 * or close the vault
 and you go to the next step in turn ( STEP 2)
 - Parameters:
     - hero: currently attacking Character
     - randomWeapon: random Int to choose a weapon in bonus Weapon Array
     - bonusWeapons: Array that contains all the bonus weapons
 */
  private func vaultSpawn(randomWeapon: Int, hero: Character, bonusWeapons: [Weapon]){
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
            attacker.switchWeapon( attacker,from: attacker.weapon, to: bonusWeapons[randomWeapon])
          case "2":
              print("Je referme le coffre ")
          default:
              print("Je ne comprends pas")
          }
      }
  }
  }
}
