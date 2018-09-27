//
//  Game.swift
//  The Return Of The Wizard
//
//  Created by Patrick Wiley on 22/08/2018.
//  Copyright © 2018 Patrick Wiley. All rights reserved.
//


/***
Class game is controlling all the tasks of the game calling the methods from TeamFactory in case of needs
It will manage also the roll of the game.
it controls the playRoll and the different display of the game
***/

class Game {
    
    private var elementHeroe: Int = 0 // number of heroes used for the display of heroes and for the control of the answer
    
    
    var whoseTurn: Bool = true // whoseTurn is initialized at true so Team First will start choosing action either fighting or healing
    
    init(whoseTurn: Bool) {
        self.whoseTurn = whoseTurn
    }
    
    let teamFactory = TeamFactory() // creates an instance of teamFactory
    
    
    
    //=========================
    // MARK: - CONVERSATION   =
    //=========================
    
    /***
     This is the start menu which welcomes the player and ask him if he wants to play
    ***/
    
    func gameStartMenu() {
        var correctAnswer: Bool = true
        repeat {
            print("\t\t**************************************************************************************"
                + "\n\t\t*                              The Return Of The Wizard                              *"
                + "\n\t\t**************************************************************************************"
                + "\n\t\t*                                                                                    *"
                + "\n\t\t*                                 WELCOME TO THE GAME                                *"
                + "\n\t\t*                                                                                    *"
                + "\n\t\t**************************************************************************************"
                + "\n"
                + "\n Would you like to start playing ? "
                + "\n Yes(y) / No(n)"
                + "\n 👉 Your choice:❓")
            
            if let choicePlayer = readLine() { // takes the imput value of the player
                
                correctAnswer = game.controAnswerLetters(choicePlayer: choicePlayer) // control if the answer is correct ("y" or "n")
                
                switch choicePlayer {
                case "y": // If the users answer is Yes(y) then he can start creating the first Team
                    
                    print("\n"
                        + "\n\t\t**********************************"
                        + "\n\t\t*      Lets start the game       *"
                        + "\n\t\t**********************************")
                    
                    createTeamMenu()
                    
                case "n": // If the users answer is No(N) then we get back to the start Menu
                    
                    print("\n"
                        + "\n\t\t**************************"
                        + "\n\t\t*    Maybe next time     *"
                        + "\n\t\t**************************")
                    
                    game.gameStartMenu()
                    
                default:
                    
                    print(" 🤔 I don't understand")
                }
            }
        }while correctAnswer == false // as far the answer is not correct either Yes(Y) or No(n) the start menu will be on screen
    }
    /***
     The game will create with the two teams with that method
     We get the answer of the player: testing if the answer is acceptable
     ***/
    func createTeamMenu() {
        
        var teamAlias = 0 // teamAlias will block the team creation at 2, set at begin at 0
        var teamType = TeamType.firstTeam /* teamNameAlias is having two states -> First for the first Team
                                                                                -> Second for the Second Team */
        print("\n             ▶️ Description of the game ◀️"
            + "\n\n"
            + "\n ⚠️ At the beginning of the game, each player will build his team by choosing from these types of possible characters."
            + "\n Fighter: The classic attacker."
            + "\n Wizard: The Savior which can also attack with a normal spell or a death spell(it will cost him some points of life)"
            + "\n Colossus: Imposing and very resistant."
            + "\n Dwarf: His axe is powerful."
            + "\n"
            + "\n ⚠️ Each team must have 3 characters (no matter the type)."
            + "\n"
            + "\n Then the game will start. Each player will be able to fight against another selected opponent, or he can heal someone of his team."
            + "\n ⚠️ To heal, you must have at least one wizard in your team."
            + "\n"
            + "\n\n Fight well, but always with honor."
            + "\n\n           ***************************** ")
        
        repeat{ // will create two teams
            var playerAnswer: String? // that is the player answer
            var numberOfHeroes : Int = 1 // declaration of number of heroes
            let maxHeroes = 4 // set the maximum nuber of heroes at 4 so only 3 heroes will be set
            
            repeat { // loop allowing to create the two teams
                print("\n"
                    + "\n 👉 \(teamType.rawValue) Team"
                    + "\n"
                    + "\n You have to choose three heroes.")
                
                repeat {
                    game.heroesChoiceDisplay() // printing the possible choice of heroes
                    playerAnswer = game.choicePlayer(maxValue: 4) // checking if the answer is in betwwen 1 and 4
                } while playerAnswer == nil
                
                var heroName: String  // that will be the name of the hero chose by the Player
                repeat {
                    print(" 👉 How do you want to name your heroe?") // Asking the name of the Team
                    heroName = teamFactory.getHeroName().trimmingCharacters(in: .whitespaces) // takes out the blank spaces
                } while heroName.isEmpty // check if no input of name which is forbidden
                
                teamFactory.composeTeam(heroeName: heroName, heroesInt: playerAnswer! ,teamType: teamType) // adding the Heroes
                print("\n"
                    + "\n 👋 hero n°\(numberOfHeroes) is created") // printing how many heroes are created
                
                numberOfHeroes += 1 // accounting one hero added
            } while numberOfHeroes < maxHeroes // check that there are only 3 heroes by team
            
            game.statusTeamDisplay(whoseTurn: true) // shows the status of Team two (all the heroes and not only the wizard)
            teamAlias += 1
            teamType = TeamType.secondTeam
            whoseTurn.toggle() // give the hand to player Two
            
            
        } while teamAlias != 2 // teamAlias is checked if the teams are already created
        
        game.statusTeamDisplay(whoseTurn: false) // shows the status of team Two (all the heroes and not only the wizard)
        whoseTurn.toggle() // give the hand to player One
        game.actionMenuDisplay(whoseTurn: true)
        
    }
    
    
    
    //==============================
    // MARK: - CONVERSATION  TEAM  =
    //==============================
    
    /*** // managing either fight or heal action for the First Team ***/
    
    func actionTeamMenu(whoseTurn: Bool) {
        
        var playerAnswer: String? // that is the player answer
        var choiceGiven: Int = 0
        var greetings: String = "" // greetings set at no String. will change with which have the playRoll
        var maxValueDispenser: Int = 0 // give the number of heroes available
        var dispenserRow: Int = 0 // set the dispenserRow in the arrayTeam (First Team or Second Team depending on who have PlayRoll)
        var emojyDispenser: String = "" // declare the emojy dispenser and initialise it to empty. it will be set depending on the playRoll
        var heroType: TypeHero! // declaration of the type of hero variable, will allow to show to that wizard a unique power (spell of death) for all the game
        
        if teamFactory.status(whoseTurn: whoseTurn, noHeroes: true).isEmpty || teamFactory.status(whoseTurn: !whoseTurn, noHeroes: true).isEmpty { // cheks if the game is over by test of no more heroes alived in at least one array of the teams
            game.theGAmeIsFinish() // calls method which ends the game
        }
            
        else {
            if whoseTurn == true {
                emojyDispenser = "🤺"
                greetings = "Team One"
                
            } else {
                emojyDispenser = "🔱"
                greetings = "Team Two"
            }
            
            maxValueDispenser = calculateHeroes(whoseTurn: whoseTurn) // so will start our possible choice by 1 for the dispensers possibility
            elementHeroe = 0                                                                 // wizard = true (only wizard reasearch) wizard = false (all the heroes and not only the wizard)
            //        repeat {
            
            print("\n 👉 \(greetings) choose you hero \(emojyDispenser): ❓")
            repeat {
                playerAnswer = ((game.choicePlayer(maxValue: maxValueDispenser))) // controls the answer imput
            }while playerAnswer == nil
            
            dispenserRow = (Int(playerAnswer!)! - 1) // correcting the index for the array // index starts at 0
            
            heroType = teamFactory.status(whoseTurn: whoseTurn, noHeroes: false)[dispenserRow].type // controls the type of hero
            
            if heroType == TypeHero.Wizard { // if it is a wizard he can heal or attack
                choiceGiven = wizardDisplay() // the answer can be 1 or 2
            } else { // if it is a normal hero, he can only attack
                choiceGiven = normalHeroe() // the answer can only be 1
            }
            if choiceGiven == 1 { // will show the Fight menu for First Team
                fightTeamMenu(whoseTurn: whoseTurn, dispenserRow: dispenserRow)
            }
            else if choiceGiven == 2 { // will show the Heal menu for first Team
                healTeamMenu(whoseTurn: whoseTurn, dispenserRow: dispenserRow)
            }
        }
        
    }
    
    /***
     Method for counting how many heroes are in the array
     ***/
    
    func calculateHeroes(whoseTurn: Bool) -> Int {
        game.statusTeamDisplay(whoseTurn: whoseTurn)
        let elementHeroe = self.elementHeroe
        self.elementHeroe = 0
        return elementHeroe // return the number of heroes in the array of the teams
    }
    
    /*** menu for fight action for the Teams
     this menu will give him the opportunity to choose which hero of the opposite team, he ll like to attack.that menu
     will give him also before taking a decision the status of his team and the status of the opposite team
     ***/
    
    func fightTeamMenu(whoseTurn: Bool, dispenserRow: Int) {
        
        var playerAnswer: String? // the answer of the user
        let dispenserRow: Int = dispenserRow // this is the dispenser heroName
        var recipientRow: Int = 0 // this is the recipient heros row
        var maxValueRecipient: Int = 0 // Value max for showing the heroes of recipient team
        var emojyRecipient: String = "" // emojy is declare for the recipient
        var heroType: TypeHero! // variable used for having the type of hero dispenser who would like to fight
        let specialSpell: Bool = false // property allowing to do a deathSpell for the wizard only
        var greetings: String // greetings message
        maxValueRecipient = calculateHeroes(whoseTurn: !whoseTurn) /* so will start our possible choice by 1 for the recipients possibility
         (all the heroes and not only the wizard) */
        
        elementHeroe = 0
        if whoseTurn == true {
            emojyRecipient = "🔱"
            greetings = "Team One "
        }
        else {
            emojyRecipient = "🤺"
            greetings = "Team Two "
        }
        heroType = teamFactory.status(whoseTurn: whoseTurn, noHeroes: false)[dispenserRow].type // checks the type of hero so it can remind that wizard can spell
        
        if heroType == .Wizard {
            print("\n ⚡️ I am a wizard"
                + "\n ⚡️ I can kill with spell of death")
        }

        print("\n 👉 \(greetings) choose your opponent \(emojyRecipient): ❓")
        
        repeat {
            playerAnswer = (game.choicePlayer(maxValue: maxValueRecipient)) // testing the correct anser with choicePlayer method
        }while playerAnswer == nil
        
        recipientRow = (Int(playerAnswer!)! - 1) // correcting the index for the array // index starts at 0
        game.newEquipementDisplay(whoseTurn: whoseTurn, heroeType: heroType, heroIndex: dispenserRow) // giving a new equipement to the hero
        game.fightTeamDisplay(dispenser: dispenserRow, recipient: recipientRow, whoseTurn: whoseTurn, spell: specialSpell) // calls the method for displaying the fight action.
        game.actionMenuDisplay(whoseTurn: !whoseTurn) // allows to go back tho the display of actionMenu after changing the roll game
        
    }
    
    /***
     Menu for healing someone before an action
     based on whoseTurn(boolean true Team First/ false team Second)
     and will give the opportunity to choose which hero, he ll like to heal.
     ***/
    
    func healTeamMenu(whoseTurn: Bool, dispenserRow: Int) {
        
        var playerAnswer: String? // the answer of the user
        var recipientRow: Int = 0 // this is the recipient heros row
        var maxValueRecipient: Int = 0 // Value max for showing all the heroes of dispenser team
        
        maxValueRecipient = calculateHeroes(whoseTurn: whoseTurn) // we will get the dispensers(all heroes) possibility
        elementHeroe = 0
        
        if whoseTurn == true {
            print(" 👉 Team One \n Choose the hero to heal: ❓")
        }
        else {
            print(" 👉 Team Two \n Choose the hero to heal: ❓")
        }
        
        repeat {
            playerAnswer = (game.choicePlayer(maxValue: maxValueRecipient)) // checks answer rightness
        }while playerAnswer == nil
        recipientRow = (Int(playerAnswer!)!-1) // correcting the index for the array // index starts at 0
        
        game.teamHealingDisplay(dispenser: dispenserRow, recipient: recipientRow, whoseTurn: whoseTurn) // displays the heal effect
        game.actionMenuDisplay(whoseTurn: !whoseTurn) // allows to go back tho the display of actionMenu after changing the roll game
        
    }
    
    
    
    
    //==============================
    // MARK: - DISPLAY  TEAM  =
    //==============================
    /***
     Displays the choice of heroes
     ***/
    func heroesChoiceDisplay() {
        
        print("\n Which hero would you like to choose?")
        print("\n 1. Fighter"
            + "\n 2. Wizard"
            + "\n 3. Colossus"
            + "\n 4. Dwarf"
            + "\n"
            + "\n 👉 Your choice: ❓")
    }
    /***
     Displays the following before an action
     based on whoseTurn(boolean true Team First/ false team Second)
     ***/
    func actionMenuDisplay(whoseTurn: Bool) {
        print(""
            + "\n\t\t***************************"
            + "\n\t\t⚡️  THE GAME: ACTION MENU *"
            + "\n\t\t***************************")
        
        actionTeamMenu(whoseTurn: whoseTurn) // continues by going to the method actionTeamMenu
    }
    /***
     Displays the status of the team in play roll before an action
     based on whoseTurn(boolean true Team First/ false team Second)
     ***/
    func statusTeamDisplay(whoseTurn: Bool) {
        
        var array = [Heroes]()
        var emojy: String = ""
        
        array = teamFactory.status(whoseTurn: whoseTurn, noHeroes: false)
        
        if whoseTurn == true { // if team one has to play then we are accessing to the arrayFirstTeam
            print("\n\n\t\t▶️ TEAM ONE HEROES ◀️")
            emojy = "🤺" // setting the emojy for team One
        }
        else { // if team one has to play then we are accessing to the arraySecondTeam
            print("\n\n\t\t▶️ TEAM TWO HEROES ◀️")
            emojy = "🔱" // setting the emojy for team Two
        }
        for element in 0..<array.count {
            if array[element].alive == true { // print the alived heroes only
                printHeroStatus(emojy: emojy, hero: array[element])
            }
            elementHeroe += 1
        }
    }
    
    /***
     Display the result of the fight
     all fighters including wizard can fight
     Spell will manage the right of SpellDeath
     ***/
    func fightTeamDisplay(dispenser: Int, recipient: Int, whoseTurn: Bool, spell: Bool) {
        var arrayDispenser = [Heroes]() // array of the dispensers
        var arrayRecipient = [Heroes]() // array of the recipients
        var emojyDispenser: String = "" // emojy for the dispenser
        var emojyRecipient: String = "" // emojy for the recipient
        var newLifeStrength: Int = 0
        
        arrayDispenser = teamFactory.status(whoseTurn: whoseTurn, noHeroes: false) // setting the arrayDispenser to arrayFirstTeam
        
        arrayRecipient = teamFactory.status(whoseTurn: !whoseTurn, noHeroes: false) // setting the arrayRecipient to arraySecondTeam
        
        
        if whoseTurn == true { // if team one has to play then we are accessing to the arrayFirstTeam
            //print("\n\n\t\t▶️ TEAM ONE HEROES ◀️")
            emojyDispenser = "🤺" // setting the emojy for the team attacking
            emojyRecipient = "🔱" // setting the emojy for the team attacked
        }
        if whoseTurn == false { // if team one has to play then we are accessing to the arraySecondTeam
            //print("\n\n\t\t▶️ TEAM TWO HEROES ◀️")
            emojyDispenser = "🔱" // setting the emojy for the team attacking
            emojyRecipient = "🤺" // setting the emojy for the team attacked
        }
        if arrayDispenser[dispenser].type == .Wizard {
            game.teamFightWizardDisplay(dispenser: dispenser, recipient: recipient, whoseTurn: whoseTurn, spell: true)
        }
        else {
            
            print("\n 👉 You were attacked by:")
            game.printHeroStatus(emojy: emojyDispenser, hero: (arrayDispenser[dispenser])) // displays the hero dispenser
            print("\n 👉 Before the attack no wizard")
            game.printHeroStatus(emojy: emojyRecipient, hero: (arrayRecipient[recipient])) // displays the hero recipient
            newLifeStrength = teamFactory.fight(dispenser: dispenser, recipient: recipient, whoseTurn: whoseTurn, specialSpell: !(arrayDispenser[dispenser].type != .Wizard)) // gets the attack result
            print("\n 👉After the attack:")
            game.printHeroStatus(emojy: emojyRecipient, hero: (arrayRecipient[recipient])) // displays the hero recipient
            
            
            if newLifeStrength == 0 {
                print("\n 👉 😢 This hero is dead!!") // displays the hero recipient is dead
            }
        }
        
    }
    
    /***
     Display the choice of spell if it is a wizard chose
     ***/
    func teamFightWizardDisplay(dispenser: Int, recipient: Int, whoseTurn: Bool, spell: Bool) {
        
        var arrayDispenser = [Heroes]() // array of the dispensers
        var arrayRecipient = [Heroes]() // array of the recipients
        var emojyDispenser: String = "" // emojy for the dispenser
        var emojyRecipient: String = "" // emojy for the recipient
        var newLifeStrength: Int = 0 // point of life of the recipient after action
        var answer: Int = 0 // answer from the player for his choice between normal spell and death spell
        var playerAnswer: String? // Answer of the player will be checked by the method choicePlayer
        
        arrayDispenser = teamFactory.status(whoseTurn: whoseTurn, noHeroes: false) // setting the arrayDispenser to arrayFirstTeam
        arrayRecipient = teamFactory.status(whoseTurn: !whoseTurn, noHeroes: false) // setting the arrayRecipient to arraySecondTeam
        
        
        if whoseTurn == true { // if team one has to play then we are accessing to the arrayFirstTeam
            print("\n\n\t\t▶️ TEAM ONE HEROES ◀️")
            emojyDispenser = "🤺" // setting the emojy for the team attacking
            emojyRecipient = "🔱" // setting the emojy for the team attacked
        }
        if whoseTurn == false { // if team one has to play then we are accessing to the arraySecondTeam
            print("\n\n\t\t▶️ TEAM TWO HEROES ◀️")
            emojyDispenser = "🔱" // setting the emojy for the team attacking
            emojyRecipient = "🤺" // setting the emojy for the team attacked
        }
        
        repeat {
            
            print("\n"
                + "\n What Would you like to do:"
                + "\n 1. Would you like to do normal Spell?"
                + "\n 2. Would You like to Spell of death?"
                + "\n"
                + "\n 👉 Your choice:❓")
            
            playerAnswer = (game.choicePlayer(maxValue: 2)) // checks answer rightness
            
        }while playerAnswer == nil // until the answer is correct
        
        answer = (Int(playerAnswer!)!) // imput is casted
        
        
        if answer == 1  { // if answer is normal spell
            print("\n 👉 \(emojyRecipient) Before the attack")
            game.printHeroStatus(emojy: emojyRecipient, hero: (arrayRecipient[recipient])) // print the characters of recipient hero
            newLifeStrength = teamFactory.fight(dispenser: dispenser, recipient: recipient, whoseTurn: whoseTurn, specialSpell: false)
            print("\n 👉 \(emojyRecipient) After the attack")
            game.printHeroStatus(emojy: emojyRecipient, hero: (arrayRecipient[recipient])) // print the characters of recipient hero
            if newLifeStrength == 0 { // check if hero is dead
                print("\n 👉 \(emojyRecipient) Your hero \(arrayRecipient[recipient].heroName) is dead  😢")
            }
        }
        if answer == 2  { // if answer is spell of death
            print("\n 👉 \(emojyRecipient) Before the attack with spell of death")
            game.printHeroStatus(emojy: emojyRecipient, hero: (arrayRecipient[recipient])) // print the characters of recipient hero
            newLifeStrength = teamFactory.fight(dispenser: dispenser, recipient: recipient, whoseTurn: whoseTurn, specialSpell: true)
            print("\n 👉 \(emojyRecipient) After the attack")
            game.printHeroStatus(emojy: emojyRecipient, hero: (arrayRecipient[recipient])) // print the characters of recipient hero
            print("\n 👉 \(emojyDispenser) ⚡️ Your wizard is now having :")
            game.printHeroStatus(emojy: emojyDispenser, hero: (arrayDispenser[dispenser])) // print the characters of dispenser hero
            print("\n 👉 \(emojyRecipient) Your hero \(arrayRecipient[recipient].heroName) is dead  😢")
        }
        
    }
    /***
    Displays team is healing someone
     ***/
    func teamHealingDisplay(dispenser: Int, recipient: Int, whoseTurn: Bool) {
        
        var newLifeStrength: Int // new life strenght value declaration
        var arrayDispenser = [Heroes]() // array of the dispenser team
        var arrayRecipient = [Heroes]() // array of the recipient team
        let recipient: Int = recipient // declaration of the recipient value
        let dispenser: Int = dispenser // declaration of the dispenser value
        var emojyDispenser: String = "" // emojy for the dispenser
        
        arrayDispenser = teamFactory.status(whoseTurn: whoseTurn, noHeroes: false) // returns the aarray of dispenser
        arrayRecipient = teamFactory.status(whoseTurn: whoseTurn, noHeroes: false) // returns the array of recipient
        
        
        if whoseTurn == true {
            emojyDispenser = "🤺" // emojy for the dispenser
        } else {
            emojyDispenser = "🔱" // emojy for the dispense
        }
        print("\n 👉 \(emojyDispenser) The savior is:")
        game.printHeroStatus(emojy: emojyDispenser, hero: (arrayDispenser[dispenser])) // print the characters of dispenser hero
        print("\n 👉 \(emojyDispenser) Before the heal Action")
        game.printHeroStatus(emojy: emojyDispenser, hero: (arrayRecipient[recipient])) // print the characters of recipient hero
        newLifeStrength = teamFactory.heal(dispenser: dispenser, recipient: recipient, whoseTurn: whoseTurn)
        print("\n 👉 \(emojyDispenser) The hero you have just heal:")
        game.printHeroStatus(emojy: emojyDispenser, hero: (arrayRecipient[recipient])) // print the characters of dispenser hero
        print("\n 👉 Your hero is now having: \(newLifeStrength)")
    }
    /***
     methods wich allows with random a new equipement
     ***/
    
    func newEquipementDisplay(whoseTurn: Bool, heroeType: TypeHero, heroIndex: Int) { // method for randoming the new equipement
        
        var arrayTeam = [Heroes]() // declaration of the array which will contain the array from the team in play
        var equipementRoll: Int = 0 // declaration of the equipementRoll, will contain the resust of the random method
        var emojy: String = "" // Declaration of the emojy for the game display
        
        if whoseTurn == true { /*** check which turn it is to define emojy and the arrayTeam datas ***/
            arrayTeam = teamFactory.teamFirst.arrayTeam
            emojy = "🤺"
        } else {
            arrayTeam = teamFactory.teamSecond.arrayTeam
            emojy = "🔱"
        }
        
        print(""
            + "\n\t\t***************************"
            + "\n\t\t* 🎲  A chest opens  2    *"
            + "\n\t\t***************************")
        
        if heroeType == .Wizard {
            arrayTeam[heroIndex].equipment = Equipment.Scepter
            print("\n 👉 \(emojy) You have a brand new Scepter")
        }
        else {
            equipementRoll = (Int.random(max: 3)-1)
            //print(equipementRoll)
            
            let NewWeaponPlayer = equipementRoll
            switch NewWeaponPlayer {
            case 0 :
                
                arrayTeam[heroIndex].equipment = Equipment.Axe // set the equipement of the hero with enum Equipement at axe
                print(" 👉 \(emojy) You have a brand new Axe")
                
            case 1 :
                
                arrayTeam[heroIndex].equipment = Equipment.Hammer // set the equipement of the hero with enum Equipement at hammer
                print(" 👉 \(emojy) You have a brand new Hammer")
                
            case 2 :
                
                arrayTeam[heroIndex].equipment = Equipment.Sword // set the equipement of the hero with enum Equipement at sword
                print(" 👉 \(emojy) You have a brand new Sword")
                
            default : print("You must choose a Weapon")
            }
        }
    }
    /***
     Method displays the possible choices for a wizard
     ***/
    
    func wizardDisplay() -> Int {
        
        var playerAnswer: String? // declaration of the answer from the player
        var choiceGiven: Int
        print("\n"
            + "\n What Would you like to do:"   // the game should propose First team to play with an action to do
            + "\n 1. Would you like to fight?"
            + "\n 2. Would You like to heal someone?"
            + "\n"
            + "\n 👉 Your choice:❓")
        repeat {
            
            playerAnswer = (game.choicePlayer(maxValue: 2)) // control if answer is correct 1 or 2 and no letters
            
        }while playerAnswer == nil // not correct answer
        choiceGiven = Int(playerAnswer!)!
        return choiceGiven // return the correct answer casted in Int
    }
    /***
     Method displays the only choice possible for an hero
     ***/
    
    func normalHeroe() -> Int {
        
        var choiceGiven: Int
        
        print("\n 👉 You are going to fight")
        choiceGiven = 1 // the player as he is having a normal hero in playRoll can just attack so no choice
        return choiceGiven
    }
    
    /***
     Method displays the hero characters
     ***/
    
    func printHeroStatus(emojy: String, hero: Heroes) {
        print("\n\(emojy) Hero name : \(hero.heroName)"
            + " \(emojy) Hero Type : \(hero.type)"
            + "\n\(emojy) LifeStrenght : \(hero.lifeStrength)"
            + " \(emojy) ShotStrenght : \(hero.shotStrength)"
            + "\n\(emojy) ArmorStrength : \(hero.armorStrength)"
            + " \(emojy) Equipement : \(hero.equipment)")
    }
    
    /***
     Method displays when the game is over
     ***/
    
    func theGAmeIsFinish() {
        print("\n 👉 The game is finish")
        if teamFactory.status(whoseTurn: true, noHeroes: false).isEmpty {
            print("\n 🎉 Team One you won!!")
        }
        else {
            print("\n 🎉 Team Two you won!!")
        }
    }
    
    //========================
    //  MARK:  - PARAMETERS  =
    //========================
    
    /***
     Method controls if the choice answer is correct: Here only "y" or "n"
     ***/
    
    func controAnswerLetters(choicePlayer: String) -> Bool { // passing the player answer in parameter to being ckecked
        var correctTwo = true // declaration of the boolean with we could test the player answer
        let choiceGiven = choicePlayer
        
        if choiceGiven != "y" && choiceGiven != "n" {
            correctTwo = false
        }
        return correctTwo
    }
    
    /***
     Method controls if the choice answer is correct: Here only "y" or "n"
     ***/
    func choicePlayer(maxValue: Int) -> String? { // passing maxValue in parameter to being compared to the answer imput
        
        let choicePlayer = readLine()! // readline from the player answer
        
        guard (choicePlayer.isInt) else {  // test if the answer is only Int no letters
            print("I don`t understand your answer")
            return nil
            
        }
        
        let control = controlAnswer(choicePlayer: Int(choicePlayer)!, maxValue: maxValue) // compares the answer imput with maxValue
        
        if control { // if the answer is in between the gap of possible answers
            //print("all is perfect")
            return choicePlayer}
        else {
            print("I don`t understand your answer")
            return nil
        }
    }
    
    /***
     Method compares the answer imput with maxValue
     ***/
    func controlAnswer(choicePlayer: Int,maxValue: Int) -> Bool {
        for num in 1...maxValue {
            if choicePlayer == num { // Answer must be contained between 1 and max for 2 possible answers then 1 or 2
                //print("Your value is in between the possible answers")
                return true
            }
            //return false
        }
        return false
    }
    
}


