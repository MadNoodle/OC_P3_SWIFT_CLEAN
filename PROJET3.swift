


// MARK: LES PERSONNAGES

//Defintion Objet personnage qui stocke les caracteristiques communes
class Character {
    let name : String // Nom du combattant
    var classe : String //Profession champion
    var health : Int //pts de vie
    
    init(name:String, classe : String, health : Int){
        self.name = name
        self.classe = classe
        self.health = health
    }

}

enum Classe {
    case warrior, mage, colossus, dwarf
}

// MARK: FUNCTIONS

// Donner un nom à son champion
func nameChamp() -> Character? {
    if let nameChamp = readLine(){
        let champion = Character(name:nameChamp, classe:"", health:100)
        print("votre personnage s'appelle \(champion.name) et a \(champion.health)pts de vie")
        return champion
    }
    return nil
    
}


// MARK : DIALOGUES

// ETAPE 1 :Choisir le nom de son guerrier
print ("comment s'appelle votre guerrier?")
nameChamp()

// ETAPE 2: Choisir une classe
print("Veuillez choisir votre champion"
    + "\n 1. Combattant"
    + "\n 2. Mage"
    + "\n 3. Colosse"
    + "\n 4. Nain")










