import Foundation

// ///////////////  //
// MARK: GAME       //
// ///////////////  //

class Game {
    var player1:Player
    var player2:Player
    
    init(player1:Player, player2:Player){
        self.player1 = player1
        self.player2 = player2
    }
    
    //Launch a new Game
    func newGame(){
        player1.createPlayerTeam()
        player2.createPlayerTeam()
   
        //TURN BY TURN LOGIC
        while player1.playerTeam.count>0 || player2.playerTeam.count>0{
            player1.turn(enemyPlayer:player2)
            player2.turn(enemyPlayer:player1)
        }
        
        //WINNING CONDITIONS
        if player1.playerTeam[0].health == 0 && player1.playerTeam[1].health == 0 && player1.playerTeam[2].health == 0 {print("\(player2.name) GAGNE")}
        else if player2.playerTeam[0].health == 0 && player2.playerTeam[1].health == 0 && player2.playerTeam[2].health == 0 {print("\(player1.name) GAGNE")}
         }
}

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

    //SHOW CHAR DETAILS
    func showTeamDetail (id:Int) ->String {
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
    
    // //////////////////////  //
    // MARK: PLAYER TURN CHOICE //
    // //////////////////////  //
    // Different actions a player can do during a turn
    func turn(enemyPlayer:Player){
        
        print ("=====================AU TOUR DU JOUEUR \(self.id) DE JOUER====================="
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

        //Choose your fighter
        print("Choisissez votre attaquant"
            + "\n 1. \(self.showTeamDetail(id:0))"
            + "\n 2. \(self.showTeamDetail(id:1))"
            + "\n 3. \(self.showTeamDetail(id:2))")
/**
 Todo: Add a check to disable dead players
 */
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
        randomSpawnWeapon()
        if fighter[0].classe == .mage {
            //Choose your fighter
            print("Choisissez la personne que vous voulez soigner"
                + "\n 1. \(self.showTeamDetail(id:0))"
                + "\n 2. \(self.showTeamDetail(id:1))"
                + "\n 3. \(self.showTeamDetail(id:2))")
            
            if let choice = readLine(){
                var target:Character
                
                
                switch choice {
                case "1":
                    target = self.playerTeam[0]
                    fighter.append(target)
                    heal(attacker:fighter[0], target:fighter[1])
                    fighter.removeAll()
                    
                case "2":
                    target = self.playerTeam[1]
                    fighter.append(target)
                    heal(attacker:fighter[0], target:fighter[1])
                    fighter.removeAll()
                case "3":
                    target = self.playerTeam[2]
                    fighter.append(target)
                    heal(attacker:fighter[0], target:fighter[1])
                    fighter.removeAll()
                default:
                    print("Je ne comprends pas")
                }
                
            }
            
        }else{
        //Choose your victim
        print("Choisissez votre cible"
            + "\n 1. \(enemyPlayer.showTeamDetail(id:0)) "
            + "\n 2. \(enemyPlayer.showTeamDetail(id:1)) `"
            + "\n 3. \(enemyPlayer.showTeamDetail(id:2))")
        
        if let choice = readLine(){
              var target:Character
     
  
            switch choice {
            case "1":
                target = enemyPlayer.playerTeam[0]
                fighter.append(target)
                attack(attacker:fighter[0], target:fighter[1])
                fighter.removeAll()

            case "2":
                target = enemyPlayer.playerTeam[1]
                fighter.append(target)
                attack(attacker:fighter[0], target:fighter[1])
                fighter.removeAll()
            case "3":
                target = enemyPlayer.playerTeam[2]
                fighter.append(target)
                attack(attacker:fighter[0], target:fighter[1])
                fighter.removeAll()
            default:
                print("Je ne comprends pas")
            }
            
        }

    }
    }
    
    //RANDOM SPAWN WEAPON
    func randomSpawnWeapon(){
        let interval = Int(arc4random_uniform(UInt32(6)))
        let randomWeapon = Int(arc4random_uniform(UInt32(6)))
        print ("\u{001B}[0;32m\(interval)\u{001B}[0;37m")

        if interval > 3 {
            print("\u{001B}[0;32mSURPRISE !!! Un coffre apparait. Vous l'ouvrez et découvrez une \(randomWeapon)"
                + "\n1. Vous vous équipez avec \(randomWeapon)"
                + "\n2. Vous gardez votre arme\u{001B}[0;37m")
        }
    }
    
    // ATTACK => DO DAMAGES
    func attack(attacker:Character, target:Character){
        //Deal Damage
            target.health -= attacker.weaponDmg
        //Check if the character dies
        if target.health <= 0 {
            print ("☠️  \(target.name) est mort☠️ ☠️")
            target.weaponDmg = 0
            target.icon = "☠️"
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
    
   

}

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

//Enum of all classes
enum Classe {
    case warrior, mage, colossus, dwarf
}

class Weapon {
    var damages:Int
    var name:String
    
    init(name:String, damages:Int){
        self.name = name
        self.damages = damages
    }
}

// ///////////////  //
// MARK: LOGIC     //
// ///////////////  //
let player1 = Player(id:1)
let player2 = Player(id:2)
let game = Game(player1:player1,player2:player2)
game.newGame()






