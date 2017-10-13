
// ///////////////  //
// MARK: PLAYERS //
// ///////////////  //

class Player {
    var id : Int
    var playerTeam = [Character]()
    
    init(id:Int){
        self.id = id
    }
    
    func win(){}
    func lose(){}
    
    //creer son équipe
    func createPlayerTeam(){
        
        print("LE JOUEUR \(self.id) VA COMPOSER SON EQUIPE")
        while playerTeam.count<4{
            let hero = createHero()
            
            //Verification si le personnage existe déjà
            if playerTeam.contains (where: { $0.name == hero.name }) {
                print("Ce guerrier existe déjà, Choisissez un autre nom")
            } else {
                //ajout du hero généré dans le tableau
                playerTeam.append(hero)
                //limite la taille de l'équipe à 4 Héros
                }
            
            if playerTeam.count == 4 {
                print("\u{001B}[0;31m⚔ ⚔ ⚔ ⚔ ⚔ ⚔ ⚔ ⚔VOUS ETES PRET A COMBATTRE⚔ ⚔ ⚔ ⚔ ⚔ ⚔ ⚔ ⚔\u{001B}[0;37m")
            }
        }
    }
    
    // Montrer son équipe
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
    
    func turn(){
        print ("=====================AU TOUR DU JOUEUR \(self.id) DE JOUER====================="
            + "\n Que souhaitez vous faire?"
            + "\n1. 👁 voir l'état de votre équipe"
            + "\n2. ⚔ attaquer")
        
        if let userChoice = readLine(){
            switch userChoice {
            case "1":
                showTeam()
                turn()
            case "2":
                print("J'attaque")
            default:
                print("Je ne comprends pas")
            }
        }
    }
}
// ///////////////  //
// MARK: CHARACTERS //
// ///////////////  //

//Defintion Objet personnage qui stocke les caracteristiques communes
class Character {
    let name : String // Nom du combattant
    var classe : Classe//Profession champion
    var health : Int // Points de vie
    var damages : Int // Valeurs Dégats ou soins pour mages
    
    init(name:String, classe : Classe){
        self.name = name
        self.classe = classe
        //Caracteristiques des classes
        switch self.classe{
        case .warrior:
                self.health = 100
                self.damages = 10
        case .mage:
                self.health = 50
                self.damages = -20 //valeur négative car soins (trouver une manière plus élégante)
        case .colossus:
                self.health = 150
                self.damages = 2
        case .dwarf:
                self.health = 25
                self.damages = 30
        }
    }
    
    
    
}

enum Classe {
    case warrior, mage, colossus, dwarf
}

// ///////////////  //
// MARK: FUNCTIONS  //
// ///////////////  //

// CREER UN CHAMPION

func createHero() -> Character{
    // Donner un nom à son champion
    print ("comment s'appelle votre guerrier?")
    var name = ""
    if let nameChamp = readLine(){
        name = nameChamp
        print("Votre héros s'appelle \(nameChamp)")
    }
    // Choisir sa classe
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
    //Création du champion
    let champion = Character(name:name,classe:classe)
    return champion
    }


// ///////////////  //
// MARK: GAME       //
// ///////////////  //

//tableau qui contiendra l'équipe du jour

let player1 = Player(id:1)
let player2 = Player(id:2)

player1.createPlayerTeam()
player1.showTeam()
player2.createPlayerTeam()
player2.showTeam()

while player1.playerTeam.count>0 && player2.playerTeam.count>0 {
    player1.turn()
    player2.turn()
}

if player1.playerTeam.count == 0 {print("LE JOUEUR 2 à GAGNER")} else if player2.playerTeam.count == 0 {print("LE JOUEUR 1 à GAGNER")}






