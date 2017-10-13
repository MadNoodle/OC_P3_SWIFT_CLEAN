


// MARK: LES PERSONNAGES

//Defintion Objet personnage qui stocke les caracteristiques communes
class Character {
    let name : String // Nom du combattant
    var classe : Classe//Profession champion
    var health : Int // Points de vie
    var damages : Int // Valeurs Degats ou soins pour mages
    
    init(name:String, classe : Classe){
        self.name = name
        self.classe = classe
        
        switch self.classe{
        case .warrior:
                self.health = 100
                self.damages = 10
        case .mage:
                self.health = 50
                self.damages = 20
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

// Donner un nom à son champion

func createHero(){
    print ("comment s'appelle votre guerrier?")
    var name = ""
    if let nameChamp = readLine(){
        name = nameChamp
        print("Votre héros s'appelle \(nameChamp)")
    }
    
    print ("Quelle est la profession du champion?"
        + "\n1. Guerrier"
        + "\n2. Mage"
        + "\n3. Colosse"
        + "\n4. Nain")
    
    var classe:Classe!
    if let choice = readLine(){
        switch choice {
        case "1":
            classe = .warrior
            print("vous avez choisit un guerrier")
        case "2":
            classe = .mage
            print("vous avez choisit un mage")
        case "3":
            classe = .colossus
            print("vous avez choisit un colosse")
        case "4":
            classe = .dwarf
            print("vous avez choisit un nain")
        default:
            print("Choisissez une classe")
        }
    }
    
    let champion1 = Character(name:name,classe:classe)
    let description = "================================="
                    + "\n      Nom :    \(champion1.name) "
                    + "\n      Classe : \(champion1.classe)"
                    + "\n      Vie :    \(champion1.health) pts"
                    + "\n      Dmg :    \(champion1.damages) pts"
                    + "\n================================="
    
    print(description)
}


// MARK: DIALOGUES

createHero()





