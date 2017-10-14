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
        player1.showTeam()
        player2.createPlayerTeam()
        player2.showTeam()
   
    //Fight loop
        //TURN BY TURN LOGIC
        while player1.playerTeam.count>0 || player2.playerTeam.count>0{
            player1.turn(enemyPlayer:player2)
            player2.turn(enemyPlayer:player1)
        }
    
       
    //Winning conditions
    if player1.playerTeam.count == 0 {print("LE JOUEUR 2 à GAGNER")} else if player2.playerTeam.count == 0 {print("LE JOUEUR 1 à GAGNER")}
     }
}

// ///////////////  //
// MARK: PLAYERS //
// ///////////////  //

class Player {
    var id : Int
    var playerTeam = [Character]()
    //var enemyPlayer:Player
    
    init(id:Int){
        self.id = id
    }
    
    //Create a team
    func createPlayerTeam(){
        
        print("\u{001B}[0;33mLE JOUEUR \(self.id) VA COMPOSER SON EQUIPE\u{001B}[0;37m")
        while playerTeam.count<3{
            let hero = createHero()
            
            // CONDITIONS TO FULFILL TO CREATE A PLAYER
            
            //Name checking for duplicates
            if playerTeam.contains (where: { $0.name == hero.name }) {
                print("Ce guerrier existe déjà, Choisissez un autre nom")
            } else {
                //add hero to team
                playerTeam.append(hero)
            }
            
            //limit team's size to 3
            if playerTeam.count == 3 {
                print("\u{001B}[0;31m⚔ ⚔ ⚔ ⚔ ⚔ ⚔ ⚔ ⚔VOUS ETES PRET A COMBATTRE⚔ ⚔ ⚔ ⚔ ⚔ ⚔ ⚔ ⚔\u{001B}[0;37m")
            }
        }
    }
    
    // SHOW TEAM STATS
    func showTeam() {
        for i in 0..<playerTeam.count {
            print(
                "==========Heros n°\(i+1)=============="
                    + "\n      Nom :    \(playerTeam[i].name) "
                    + "\n      Classe : \(playerTeam[i].classe)"
                    + "\n      Vie :    \(playerTeam[i].health) pts"
                    + "\n      Dmg :    \(playerTeam[i].damages) pts"
                    + "\n=================================")
        }
    }
    //SHOW CHAR DETAILS
    func showTeamDetail (id:Int) ->String {
        let detail = "\(playerTeam[id].name) \(playerTeam[id].classe) \(playerTeam[id].health) \(playerTeam[id].damages)"
        return detail
    }
    // Different actions a player can do during a turn
    func turn(enemyPlayer:Player){
        
        print ("\n\n"
            +"=====================AU TOUR DU JOUEUR \(self.id) DE JOUER====================="
            + "\n Que souhaitez vous faire?"
            + "\n1. 👁 voir l'état de votre équipe"
            + "\n2. ⚔ attaquer")
        
        if let userChoice = readLine(){
            
            switch userChoice {
            case "1":
                showTeam()
                turn(enemyPlayer:enemyPlayer)
            case "2":
                figth(enemyPlayer:enemyPlayer)
            case "3":
                print("soigner")
            default:
                print("Je ne comprends pas")
            }
        }
    }
    
    func figth(enemyPlayer:Player){
        var fighter = [Character]()
      
        
        print("Choisissez votre attaquant"
            + "\n 1. \(self.showTeamDetail(id:0))"
            + "\n 2. \(self.showTeamDetail(id:1))"
            + "\n 3. \(self.showTeamDetail(id:2))")

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

            case "2":
                target = enemyPlayer.playerTeam[1]
                fighter.append(target)
                attack(attacker:fighter[0], target:fighter[1])
            case "3":
                target = enemyPlayer.playerTeam[2]
                fighter.append(target)
                attack(attacker:fighter[0], target:fighter[1])
            default:
                print("Je ne comprends pas")
            }
            
        }

    }
    
    func attack(attacker:Character, target:Character){
        target.health -= attacker.damages
        print("\(attacker.name) fait \(attacker.damages) points de dommage à\(target.name). il lui reste \(target.health) points de vie.")
         fighter.removeAll()
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
    var damages : Int // damages or heal value
    
    init(name:String, classe : Classe){
        self.name = name
        self.classe = classe
        //class caracteristics
        switch self.classe{
        case .warrior:
                self.health = 100
                self.damages = 10
        case .mage:
                self.health = 50
                self.damages = -20
        case .colossus:
                self.health = 150
                self.damages = 2
        case .dwarf:
                self.health = 25
                self.damages = 30
        }
    }

}
//Enum of all classes
enum Classe {
    case warrior, mage, colossus, dwarf
}

// ///////////////  //
// MARK: FUNCTIONS  //
// ///////////////  //

// Create a hero

func createHero() -> Character{
    // Give a name to a champ
    print ("comment s'appelle votre guerrier?")
    var name = ""
    if let nameChamp = readLine(){
        name = nameChamp
        print("Votre héros s'appelle \(nameChamp)")
    }
    // Choose character class
    print ("Quelle est sa profession ?"
        + "\n1. Guerrier"
        + "\n2. Mage"
        + "\n3. Colosse"
        + "\n4. Nain")
    
    var classe:Classe!                  // Poser question Dhia "Pourquoi je dois le forcer"
                                        // On assume qu'il a une valeur donc il faut verifier avant l entrée dans le switch
    if let choice = readLine(){
        switch choice {
        case "1":
            classe = .warrior
        case "2":
            classe = .mage
        case "3":
            classe = .colossus
        case "4":
            classe = .dwarf
        default:
            print("ERROR")
            }
        }
/**
 -ToDo : Corriger bug si pas 1234
 */
    //Hero instanciantion
    let champion = Character(name:name,classe:classe)
    return champion
    }


// ///////////////  //
// MARK: LOGIC     //
// ///////////////  //
let player1 = Player(id:1)
let player2 = Player(id:2)

let game = Game(player1:player1,player2:player2)
game.newGame()






