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
    
    // function that converts string input to input use to prevent crash when typing out of range input
    func keyInput() -> Int{
        let input = readLine(); //readLine optionnal
        return Int(input!)! //Int conversion optionnal do not remove ! !
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
        repeat {  //Sanity check to prevent out of range input crash
            print ("Quelle est sa profession ?"
                + "\n1. Guerrier"
                + "\n2. Mage"
                + "\n3. Colosse"
                + "\n4. Nain")
            userChoice = keyInput()
        } while userChoice != 1 && userChoice != 2 && userChoice != 3 && userChoice != 4
        
        //Classe selection
        var classe:Classe!  // assuming the optionnal have a value cf. sanity check
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
        
        //Hero instanciantion
        let champion = Character(name:name,classe:classe)
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
    
    // SHOW TEAM STATS DISPLAY 2
    func displayPlayerChoice(team:[Character]){
        
        for i in team {
            let index = team.index{$0 === i}!
            print(" \(index + 1 ). \(self.showTeamDetail(id:index))")
        }
    }
    
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
            default:
                print("Je ne comprends pas")
            }
        }
    }
    
    // ///////////////////  //
    // MARK: FIGHT MECANICS //
    // //////////////////  //
    func fight(enemyPlayer:Player){
        // Array where we store attacker and target ( will be cleared after each turn)
        var fighter = [Character]()
        let bonusWeapon = [Weapon(name:"Missile",damages:100), Weapon(name:"arc",damages:35), Weapon(name:"baguette de pain",damages:2), Weapon(name:"Petite cuillère",damages:1)]
        
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
        randomSpawnWeapon(bonusWeapons:bonusWeapon, hero: fighter[0])
        if fighter[0].classe == .mage {
            //HEAL A TEAMMATE
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
            //ATTACK AN ENEMY
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
                case "2":
                    target = enemyPlayer.playerTeam[1]
                    fighter.append(target)
                    target.attack(attacker:fighter[0], target:fighter[1], enemyPlayer: enemyPlayer)
                    fighter.removeAll()
                case "3":
                    target = enemyPlayer.playerTeam[2]
                    fighter.append(target)
                    target.attack(attacker:fighter[0], target:fighter[1], enemyPlayer: enemyPlayer)
                    fighter.removeAll()
                default:
                    print("Je ne comprends pas")
                }
            }
        }
    }
    
    
    //RANDOM SPAWN WEAPON LOGIC
    func randomSpawnWeapon(bonusWeapons:[Weapon], hero:Character){
        let interval = Int(arc4random_uniform(UInt32(6)))
        let randomWeapon = Int(arc4random_uniform(UInt32(3)))
        let attacker = hero
        print ("\u{001B}[0;32m ROLL \(interval)\u{001B}[0;37m")
        
        if interval > 3 {
            print("\u{001B}[0;32mSURPRISE !!! Un coffre apparait. Vous l'ouvrez et découvrez une \(bonusWeapons[randomWeapon].name)"
                + "\n1. Vous vous équipez avec \(bonusWeapons[randomWeapon].name)"
                + "\n2. Vous gardez votre arme\u{001B}[0;37m")
            
            if let choice = readLine(){
                switch choice {
                case "1":
                    print("je change d arme")
                    switchWeapon(hero:attacker,classWeapon:attacker.weapon, bonusWeapon: bonusWeapons[randomWeapon])
                case "2":
                    print("Je refrme le ")
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
    
   
}
