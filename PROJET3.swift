


// MARK: LES PERSONNAGES

//Defintion Objet personnage qui stocke les caracteristiques communes
class Character {
    let name : String // Nom du combattant
    let classe : String //Profession champion
    var health : Int //pts de vie
    
    init(name:String, classe : String, health : Int){
        self.name = name
        self.classe = classe
        self.health = health
    }

}

// MARK : DIALOGUES


// Choisir le nom de son guerrier
print ("comment s'appelle votre guerrier?")

if let nameChamp = readLine(){
    let champion = Character(name:nameChamp, classe:"testeur", health:100)
    print("votre personnage est un \(champion.classe), il s'appelle \(champion.name) et a \(champion.health)pts de vie")
}




