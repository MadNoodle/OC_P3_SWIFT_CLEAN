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
    var id : Int
    var name = ""
    var playerTeam = [Character]()
    
    
    init(id:Int){
        self.id = id
    }
    /**
 ToDo:Handle the case letters are pressed
 */
    // function that converts string input to input use to prevent crash when typing out of range input
    func keyInput() -> Int{
        let input = readLine();                                                                                             //readLine optionnal
        return Int(input!)!                                                                                                 //Int conversion optionnal do not remove ! !
    }
    
    // //////////////////////////  //
    // MARK: SELECT YOUR WARRRIORS //
    // //////////////////////////  //
    
    //CREATE TEAM
    func createPlayerTeam(){
        print("QUEL EST LE NOM DU JOUEUR \(self.id)?")
        if let playerName = readLine(){
            self.name = playerName
        }
        
        print("\u{001B}[0;33m \(self.name) VA COMPOSER SON EQUIPE\u{001B}[0;37m")
        while playerTeam.count<3{
            let hero = createHero()
            
            // CONDITIONS TO FULFILL TO CREATE A PLAYER
            if playerTeam.contains (where: { $0.name == hero.name }) {                                                      //Name checking for duplicates
                print("Ce guerrier existe déjà, Choisissez un autre nom")
            } else {
                playerTeam.append(hero)                                                                                     //add hero to team
                showTeam()
            }

            if playerTeam.count == 3 {                                                                                      //limit team's size to 3
                print("\u{001B}[0;31m⚔ ⚔ ⚔ ⚔ ⚔ ⚔ ⚔ ⚔\(self.name) EST PRET A COMBATTRE⚔ ⚔ ⚔ ⚔ ⚔ ⚔ ⚔ ⚔\u{001B}[0;37m")
            }
        }
    }
    
    // CREATE HERO
    func createHero() -> Character{
        var userChoice:Int
        
        // Give a name to a champ
        print ("\(self.name), comment s'appelle votre guerrier?")
        var name = ""
        if let nameChamp = readLine(){
            name = nameChamp
            print("Votre héros s'appelle \(nameChamp)")
        }
        
        // Choose character class
        repeat {                                                                                                            //Sanity check to prevent out of range input crash
            print ("Quelle est sa profession ?"
                + "\n1. Guerrier"
                + "\n2. Mage"
                + "\n3. Colosse"
                + "\n4. Nain")
            userChoice = keyInput()
        } while userChoice != 1 && userChoice != 2 && userChoice != 3 && userChoice != 4
        
        //Classe selection
        var classe:Classe!                                                                                                  // assuming the optionnal have a value cf. sanity check
        switch userChoice {
        case 1:
            classe = .warrior
        case 2:
            classe = .mage
        case 3:
            classe = .colossus
        case 4:
            classe = .dwarf
        default:
            break
        }
        
        let champion = Character(name:name,classe:classe)                                                                   //Hero instanciantion
        return champion
    }
    
   
    
    //SHOW CHARACTER DETAILS
    func showTeamDetail (id:Int) -> String {
        let detail:String
        if playerTeam[id].classe == .mage{
            detail = "               Nom: \(playerTeam[id].name) - \(playerTeam[id].icon)    Classe : \(playerTeam[id].classe) -     ❤️  vie:  \(playerTeam[id].health) pts -    ⚔  Arme : \(playerTeam[id].weaponName) - 💧  Soins: \(playerTeam[id].weaponDmg)"
        }else{
            detail = "               Nom: \(playerTeam[id].name) - \(playerTeam[id].icon)    Classe : \(playerTeam[id].classe) -     ❤️  vie:  \(playerTeam[id].health) pts -    ⚔  Arme : \(playerTeam[id].weaponName) - 🎯 Dommages : \(playerTeam[id].weaponDmg)"}
        return detail
    }
    
    // SHOW TEAM STATS
    func showTeam() {
        for i in 0..<playerTeam.count {
            print(
                "====Heros n°\(i+1)========================================================================================================"
                    + "\n \(showTeamDetail(id:i))"
                    + "\n=====================================================================================================================")
        }
    }
    
    // SHOW PLAYER TEAM STATS DISPLAY 2
    func displayPlayerChoice(team:[Character]){
        
        for i in team {
            let index = team.index{$0 === i}!
            print(" \(index + 1 ). \(self.showTeamDetail(id:index))")
        }
    }
    // SHOW ENEMY TEAM STATS DISPLAY 2
    func displayEnemyChoice(team:[Character],enemy:Player){
        
        for i in team {
            let index = team.index{$0 === i}!
            print(" \(index + 1 ). \(enemy.showTeamDetail(id:index))")
        }
    }
    
  
    // //////////////////////  //
    // MARK: PLAYER TURN CHOICE //
    // //////////////////////  //
    
    
    // Different actions a player can do during a turn
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
                winCheck()
            default:
                print("Je ne comprends pas")
            }
        }
    }
    
    // ///////////////////  //
    // MARK: FIGHT MECANICS //
    // //////////////////  //
    
    func fight(enemyPlayer:Player){
    
        var fighter = [Character]()                                                                      // Array where we store attacker and target ( will be cleared after each turn)
        
        //1ST STEP :Choose your fighter
        print("Choisissez votre attaquant")
        displayPlayerChoice(team:self.playerTeam)
        if let choice = readLine(){
            var attacker:Character
            
            switch choice {
            case "1":
                attacker = self.playerTeam[0]
                fighter.append(attacker)
           case "2":
                attacker = self.playerTeam[1]
                fighter.append(attacker)
            case "3":
                attacker = self.playerTeam[2]
                fighter.append(attacker)
            default:
                print("Je ne comprends pas")
            }
        }

        //RANDOM STEP: Random spawn a vault
        randomSpawnWeapon(hero: fighter[0])
        
        //STEP 2A : HEAL A TEAMMATE
        if fighter[0].classe == .mage {
            print("Choisissez la personne que vous voulez soigner")
            displayPlayerChoice(team:self.playerTeam)
            
            if let choice = readLine(){
                var target:Character
                
                switch choice {
                case "1":
                    target = self.playerTeam[0]
                    fighter.append(target)
                    target.heal(attacker:fighter[0], target:fighter[1])
                    fighter.removeAll()
                    
                case "2":
                    target = self.playerTeam[1]
                    fighter.append(target)
                    target.heal(attacker:fighter[0], target:fighter[1])
                    fighter.removeAll()
                case "3":
                    target = self.playerTeam[2]
                    fighter.append(target)
                    target.heal(attacker:fighter[0], target:fighter[1])
                    fighter.removeAll()
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
                    fighter.append(target)
                    target.attack(attacker:fighter[0], target:fighter[1], enemyPlayer: enemyPlayer)
                    fighter.removeAll()
                    print (enemyPlayer.playerTeam)
                case "2":
                    target = enemyPlayer.playerTeam[1]
                    fighter.append(target)
                    target.attack(attacker:fighter[0], target:fighter[1], enemyPlayer: enemyPlayer)
                    fighter.removeAll()
                    print (enemyPlayer.playerTeam)
                case "3":
                    target = enemyPlayer.playerTeam[2]
                    fighter.append(target)
                    target.attack(attacker:fighter[0], target:fighter[1], enemyPlayer: enemyPlayer)
                    fighter.removeAll()
                    print (enemyPlayer.playerTeam)
                default:
                    print("Je ne comprends pas")
                }
            }
        }
    }
    
    
    // RANDOM SPAWN WEAPON LOGIC
    func randomSpawnWeapon( hero:Character){
        
        let bonusWeapons = [                                                                                         //array of bonus weapons - Might be an enum
            Weapon(name:"Missile",damages:100),
            Weapon(name:"arc",damages:35),
            Weapon(name:"baguette de pain",damages:2),
            Weapon(name:"Petite cuillère",damages:1),
            Weapon(name:"poudre magique",damages:50),
            Weapon(name:"oeil de grenouille",damages:25),
            Weapon(name:"sceptre suerpuissant",damages:75)]
        
       
        if hero.classe == .mage {                                                                                   // pick a random number to propose a new weapon
            let randomWeapon = Int(arc4random_uniform(UInt32(3) + 3))                                               // weapons with index 4 to 6 are for mage
            vaultSpawn(randomWeapon:randomWeapon, hero:hero, bonusWeapons:bonusWeapons)
        } else{
            let randomWeapon = Int(arc4random_uniform(UInt32(3)))                                                   //weapons with index 0 to 3 are for others
            vaultSpawn(randomWeapon:randomWeapon, hero:hero, bonusWeapons:bonusWeapons)
        }
        
    }
    
    // VAULT SPAWN
    func vaultSpawn(randomWeapon:Int, hero:Character, bonusWeapons:[Weapon]){
    
    let interval = Int(arc4random_uniform(UInt32(6)))                                                               //Pick a random number for the vault spawning
       
    //Random sanity check @PARAMS >3
    if interval > 3 {
        print("\u{001B}[0;32mSURPRISE !!! Un coffre apparait. Vous l'ouvrez et découvrez une \(bonusWeapons[randomWeapon].name)"
            + "\n1. Vous vous équipez avec \(bonusWeapons[randomWeapon].name)"
            + "\n2. Vous gardez votre arme\u{001B}[0;37m")
        
        //vault message + options spawning in chat
        let attacker = hero
        
        if let choice = readLine(){                                                                                 //User validation
            switch choice {
            case "1":
                switchWeapon(hero:attacker,classWeapon:attacker.weapon, bonusWeapon: bonusWeapons[randomWeapon])
            case "2":
                print("Je referme le coffre ")
            default:
                print("Je ne comprends pas")
            }
        }
    }

    }
    
    //SWITCH WEAPON
    func switchWeapon(hero:Character, classWeapon:Weapon, bonusWeapon:Weapon){
        hero.weapon = bonusWeapon
        print("VOUS TAPEZ A \(bonusWeapon.damages)PTS DE DOMMAGE")
    }
    
    //WINNING CONDITIONS
    func winCheck(){
        if player1.playerTeam.count <= 0 {print("\(player2.name) GAGNE")}
        else if player2.playerTeam.count <= 0 {print("\(player1.name) GAGNE")
            
        }
    }
    
    
    
   
}
