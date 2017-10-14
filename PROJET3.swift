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
    while player1.playerTeam.count>0 && player2.playerTeam.count>0 {
    player1.turn()
    player2.turn()
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
    
    // Show team's stats
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
    //Show one character details
    func showTeamDetail (id:Int) ->String {
        let detail = "\(playerTeam[id].name) \(playerTeam[id].classe) \(playerTeam[id].health) \(playerTeam[id].damages)"
        return detail
    }
    // Different actions a player can do during a turn
    func turn(){
//let enemyPlayer:Player
        
//if player.id == 1 {enemyplayer = player.id} else {enemyplayer = player1}
        print ("=====================AU TOUR DU JOUEUR \(self.id) DE JOUER====================="
            + "\n Que souhaitez vous faire?"
            + "\n1. 👁 voir l'état de votre équipe"
            + "\n2. ⚔ attaquer")
        
        if let userChoice = readLine(){
//let target:Character
//let attacker:Character
            switch userChoice {
            case "1":
                showTeam()
                turn()
            case "2":
//                attacker = selectChar()
//                target = chooseTarget()
//                attack(target:target, attacker:attacker)
                print("attaquer")
            case "3":
                print("soigner")
            default:
                print("Je ne comprends pas")
            }
        }
    }
    
//    func selectChar() -> Character{
//
//        print("Choisissez la personne que voulez attaquer"
//            + "\n 1.\(self.showTeamDetail(id:0)) "
//            + "\n 2. \(self.showTeamDetail(id:1)) `"
//            + "\n 3. \(self.showTeamDetail(id:2))")
//
//        if let attacker = readLine(){
//            switch attacker {
//            case "1":
//                var attacker = self.playerTeam[0]
//            case "2":
//                var attacker = self.playerTeam[1]
//            case "3":
//                var attacker = self.playerTeam[2]
//            default:
//                print("Je ne comprends pas")
//            }
//            return attacker
//        }
//
//    }
//
//    func chooseTarget() -> Character {
//        if self.id == 1 { enemyPlayer = player(id:2)} else { enemyPlayer = player(id:1)}
//        print("Choisissez la personne que voulez attaquer"
//            + "\n 1.\(enemyPlayer.showTeamDetail(id:0)) "
//            + "\n 2. \(enemyPlayer.showTeamDetail(id:1)) `"
//            + "\n 3. \(enemyPlayer.showTeamDetail(id:2))")
//
//        if let target = readLine(){
//            switch target {
//            case "1":
//                return enemyPlayer.playerTeam[0]
//            case "2":
//                return enemyPlayer.playerTeam[1]
//            case "3":
//                return enemyPlayer.playerTeam[2]
//            default:
//                print("Je ne comprends pas")
//            }
//        }
//
//    }
//
//    func attack(target:Character,attacker:Character){
//        target.health -= attacker.damages
//        print(target.health)
//
//    }

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






