# Fighter Game

## Getting Started

### Prerequisites
must be running mac OS X

### Installing
clone the repository on your local machine and open Xcode and then build the project.
or:

In terminal :

```
cd /yourDirectory/OC_P3_CLEAN/Fighter_game_app
```
## How to play
This project is a part of Open Classrooms course on Ios developpment.
It is a command line RPG game where 2 players create 2 team of 3 characters with different abilities and weapons.
The first player who kills the other player characters wins.

Each player can pick a character between 4 professions :
* Warrior
* Wizard
* Colossus
* Dwarf

Each profession has a specific weapon with specific damages.

Each profession has 2 class caracteristics
* Warrior : Strength & agility
* Wizard : Intelligence & wizardry
* Colossus: Force & wizardry
* Dwarf : agility & strenght

When a player creates a character, he is prompted to choose a name, a class and to attribute 10 class points between the 2 class caracteristics.
```
For example :
A warrior can have 5 points in Force and 5 in Agility or 7 in Force and 3 in Agility
```
When the 2 teams have been created, the game is a turn by turn game.
During a turn, a player have 2 options
* Display his team to see all the current caracteristics ( health points/damages...)
* Attack

Then he has to choose an attacker . The wizard attack does cause any damage, it heals a teammate.

When attacker attacks he has a random odd to cast an offensive class ability :
* Warrior : give a critical strike
* Wizard : give a critical heal
* Colossus: invoke a minions that deals greater damages
* Dwarf : no offensive ability

At random moments, a vault can spawn at this step and propose a new weapon that can be better than class weapon or worst. The Player can choose to equip with it orrr not.

Then the attacker choose the player he wishes to attack ( or heal). We call this character the target

Before target receives damages he has a random odd to cast an defensive class ability :
* Warrior : Block the atttack ( no damage)
* Wizard : Buff the target ha an increased maximum health
* Colossus: Shield a part of the received damages
* Dwarf : "Riposte" the dwarf block the attack and give a critical strike to the attacker ( it s never a good idea to attack a dwarf).
