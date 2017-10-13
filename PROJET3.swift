


// MARK: LES PERSONNAGES

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

// MARK: FUNCTIONS

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
  
    var classe:Classe!
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
           print("Veuillez choisir une classe")
/**
- ToDo: gerer erreur quand on tape autre chose que les choix
*/
        }
    }
    //Création du champion
    let champion = Character(name:name,classe:classe)
    return champion
}

func createPlayerTeam(){
    while playerTeam.count<4{
        let hero = createHero()
        
/**
 - ToDo: Ajouter une condition pour ne pas avoir de doublons dans les noms
 */
        
        //ajout du hero généré dans le tableau
            playerTeam.append(hero)
        //limite la taille de l'équipe à 4 Héros
            for i in 0..<playerTeam.count {
                print(
                "==========Heros n°\(i+1)=============="
                    + "\n      Nom :    \(playerTeam[i].name) "
                    + "\n      Classe : \(playerTeam[i].classe)"
                    + "\n      Vie :    \(playerTeam[i].health) pts"
                    + "\n      Dmg :    \(playerTeam[i].damages) pts"
                    + "\n=================================")
            }
            
        
        
        if playerTeam.count == 4 {
            print("=================Vous etes pret à combrattre================")
        }
    }
}
// MARK: GAME

//tableau qui contiendra l'équipe du jour
var playerTeam = [Character]()

createPlayerTeam()





