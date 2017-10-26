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

## LOGIC DIAGRAM

![diagramme_logic](https://user-images.githubusercontent.com/23486492/32066946-bcf565a4-ba81-11e7-870e-8ce17bb0d912.jpeg)

![diagramme_classes](https://user-images.githubusercontent.com/23486492/32068798-8d071508-ba87-11e7-808d-c320bc2eb6d6.jpeg)

## BONUS **##

* [Link to the project] (https://github.com/MadNoodle/OC_P3_SWIFT_CLEAN.git)

**DESCRIPTION**

Each character can randomly summon a class offensive skill as it attacks and a class defensive skill while it is under attack.

![docs_image_0](https://user-images.githubusercontent.com/23486492/32068843-af9dd5b6-ba87-11e7-8b75-d30a0ad3b72c.png)

** Note: ** the dwarf class has only one defensive skill but deals damage to its enemy (so it has offensive property too).

These skills are based on class statistics: ``` Agility / Strength / Intelligence / wizardry ```. Each class is based on 2 characteristics, which will be used to calculate the probability of invoking the skill as well as the damage it will inflict or prevent.

** Breakdown of characteristics by class **:

![docs_image_1](https://user-images.githubusercontent.com/23486492/32068862-bfb1e79e-ba87-11e7-8a76-26597a7265e4.png)

** Mechanical allocation of points between the 2 characteristics **

At the time of the creation of a character, the player will have to distribute 10 points between the 2 characteristics specific to the class of the character.

**IMPLEMENTATION**

In the Character class (in charge of the character concept and its actions), we have implemented:

* 4 variables named ``` agility / force / intelligence / wizardry ```.

* 2 methods: ``` offensiveClassAbility ()``` and ```DefensiveClassAbility () ``` in charge of invoking the skill based on a random number based on the main class feature.

* ** Methods specific to each skill ** to apply the new damage of the character. This damage is calculated by algorithm based on the 2 class characteristics.

* A ```CharacterAttackReset () ```method that allows ** to return the hero's damage to their initial class damage at the end of the turn. **

In the ```Class Player ```, in charge of the player's actions during a turn we did call:

*  the method ``` CaracteristicAttribution () ```: allowing to ** spread ** the 10 points during the creation of the character and to verify ** well that the sum of the 2 characteristics is equal to 10. **

* the methods  ``` offensiveClassAbility () ``` and ```DefensiveClassAbility () ```  in the  ```Turn () ``` method to implement this feature.
