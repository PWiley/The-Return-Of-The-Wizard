class Game {
    
    private var elementHeroe: Int = 0
    
    
    var whoseTurn: Bool = true // whoseTurn is initialized at 0 so Team First will start choosing action either fighting or healing
    
    init(whoseTurn: Bool) {
        self.whoseTurn = whoseTurn
    }
    
    let teamFactory = TeamFactory()
    
    
    
    //=========================
    // MARK: - CONVERSATION   =
    //=========================
    
    func gameStartMenu() {
        var correctAnswer: Bool = true
        repeat {
            print("           **************************************************************************************"
                + "\n           *                              The Return Of The Wizard                              *"
                + "\n           **************************************************************************************"
                + "\n           *                                                                                    *"
                + "\n           *                                 WELCOME TO THE GAME                                *"
                + "\n           *                                                                                    *"
                + "\n           **************************************************************************************"
                + "\n"
                + "\n Would you like to start playing ? "
                + "\n Yes(y) / No(n)"
                + "\n 👉 Your choice:❓")
            
            if let choicePlayer = readLine() {
                
                correctAnswer = game.controAnswerLetters(choicePlayer: choicePlayer)
                
                switch choicePlayer {
                case "y": // If the users answer is Yes(y) then he can start creating the first Team
                    
                    print("\n"
                        + "\n           **********************************"
                        + "\n           *      Lets start the game       *"
                        + "\n           **********************************")
                    
                    createTeamMenu()
                    
                case "n": // If the users answer is No(N) then we get back to the start Menu
                    
                    print("\n"
                        + "\n           **************************"
                        + "\n           *    Maybe next time     *"
                        + "\n           **************************")
                    
                    game.gameStartMenu()
                    
                default: // as far the answer is not correct either Yes(Y) or No(n) the start menu will be on screen
                    
                    print(" 🤔 I don't understand")
                }
            }
        }while correctAnswer == false
    }
    /***
    The game will create with the two teams with that method
    We get the answer of the player: testing if the answer is acceptable
    ***/
    func createTeamMenu() {
        
        var teamAlias = 0 // teamAlias will block the team creation at 2, set at begin at 0
        var teamType = TeamType.firstTeam /* teamNameAlias is having two states -> First for the first Team
         -> Second for the Second Team*/
        print("\n             ▶️ Description of the game ◀️"
            + "\n\n"
            + "\n ⚠️ At the beginning of the game, each player will build his team by choosing from these types of possible characters."
            + "\n Fighter: The classic attacker."
            + "\n Wizard: The Savior."
            + "\n Colossus: Imposing and very resistant."
            + "\n Dwarf: His axe is powerful."
            + "\n"
            + "\n ⚠️ Each team must have 3 characters (no matter the type)."
            + "\n"
            + "\n Then the game will start. Each player will be able to fight against another chosen opponent, or he can heal someone of his team."
            + "\n ⚠️ To heal, you must have at least one wizard in your team."
            + "\n"
            + "\n\n Fight well, but always with honor."
            + "\n\n           ***************************** ")
        
        repeat{ // will create two teams
            var playerAnswer: String? // that is the player answer
            var numberOfHeroes : Int = 1
            let maxHeroes = 4
            
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
                    heroName = teamFactory.getHeroeName().trimmingCharacters(in: .whitespaces)
                } while heroName.isEmpty // check if no input of name which is forbidden
                
                teamFactory.composeTeam(heroeName: heroName, heroesInt: playerAnswer! ,teamType: teamType) // adding the Heroes
                print("\n"
                    + "\n 👋 hero n°\(numberOfHeroes) is created") // printing how many heroes are created
                
                numberOfHeroes += 1 // accounting one hero added
            } while numberOfHeroes < maxHeroes // check that there are only 3 heroes by team
            
            game.statusTeamDisplay(whoseTurn: true,wizard: false) // shows the status of Team two (all the heroes and not only the wizard)
            teamAlias += 1
            teamType = TeamType.secondTeam
            whoseTurn.toggle() // give the hand to player Two
            
            
        } while teamAlias != 2 // teamAlias is checked if the teams are already created
        
        game.statusTeamDisplay(whoseTurn: false,wizard: false) // shows the status of team Two (all the heroes and not only the wizard)
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
        var heroType: HeroType! // declaration of the type of hero variable, will allow to show to that wizard a unique power (spell of death) for all the game
        
        
        if teamFactory.status(whoseTurn: whoseTurn).isEmpty || teamFactory.status(whoseTurn: !whoseTurn).isEmpty {
            game.theGAmeIsFinish()
        }
        else {
            if whoseTurn == true {
                emojyDispenser = "🤺"
                greetings = "\n\n           ▶️ TEAM ONE ◀️"
                
            } else {
                emojyDispenser = "🔱"
                greetings = "\n\n           ▶️ TEAM TWO ◀️"
            }
            
            maxValueDispenser = calculateHeroes(whoseTurn: whoseTurn, wizard: false) // so will start our possible choice by 1 for the dispensers possibility
            elementHeroe = 0                                                                 // wizard = true (only wizard reasearch) wizard = false (all the heroes and not only the wizard)
            //        repeat {
            print("\(greetings)")
            print("\n 👉 Choose you hero \(emojyDispenser): ❓")
            repeat {
                playerAnswer = ((game.choicePlayer(maxValue: maxValueDispenser)))
            }while playerAnswer == nil
            
            dispenserRow = (Int(playerAnswer!)! - 1) // correcting the index for the array // index starts at 0
            
            heroType = teamFactory.status(whoseTurn: whoseTurn)[dispenserRow].type
            
            if heroType == .Wizard {
                choiceGiven = wizardDisplay()
            } else {
                choiceGiven = normalHeroe()
            }
            if choiceGiven == 1 { // will show the Fight menu for First Team
                game.newEquipementDisplay(whoseTurn: whoseTurn, heroeType: heroType, heroIndex: dispenserRow)
                fightTeamMenu(whoseTurn: whoseTurn, dispenserRow: dispenserRow)
            }
            else if choiceGiven == 2 { // will show the Heal menu for first Team
                healTeamMenu(whoseTurn: whoseTurn, dispenserRow: dispenserRow)
            }
            
            print(!teamFactory.status(whoseTurn: !whoseTurn).isEmpty)
        }
        
    }
    /***
    Method for counting how many heroes are in the array
    ***/
    func calculateHeroes(whoseTurn: Bool, wizard: Bool) -> Int {
        game.statusTeamDisplay(whoseTurn: whoseTurn, wizard: wizard)
        let elementHeroe = self.elementHeroe
        self.elementHeroe = 0
        return elementHeroe
    }
    
    func fightTeamMenu(whoseTurn: Bool, dispenserRow: Int) {  /* menu for fight action for the Teams
         this menu will give him the opportunity to choose which hero of the opposite
         team, he ll like to attack.that menu will give him also before taking a decision the status of his team and the status of the
         opposite team */
        
        var playerAnswer: String? // the answer of the user
        let dispenserRow: Int = dispenserRow // this is the dispenser heroName
        var recipientRow: Int = 0 // this is the recipient heros row
        var maxValueRecipient: Int = 0 // Value max for showing the heroes of recipient team
        var emojyRecipient: String = "" // emojy is declare for the recipient
        var heroType: HeroType! // variable used for having the type of hero dispenser who would like to fight
        var greetings: String = ""
        let specialSpell: Bool = false // property allowing to do a deathSpell for the wizard only
        
        maxValueRecipient = calculateHeroes(whoseTurn: !whoseTurn, wizard: false) /* so will start our possible choice by 1 for the recipients possibility
         (all the heroes and not only the wizard) */
        print(maxValueRecipient)
        elementHeroe = 0
        if whoseTurn == true {
            emojyRecipient = "🔱"
            greetings = "\n\n           ▶️ TEAM ONE ◀️"
        }
        else {
            emojyRecipient = "🤺"
            greetings = "\n\n           ▶️ TEAM TWO ◀️"            
        }
        heroType = teamFactory.status(whoseTurn: whoseTurn)[dispenserRow].type
        
        if heroType == .Wizard {
            print(" ⚡️ I am a wizard"
                + "\n I have so much power"
                + "\n ⚡️ I can kill with spell of death")
        }
        else {
            print("you are a normal hero")
        }
        
        print("\(greetings)")
        print("\n 👉 Choose your opponent \(emojyRecipient): ❓")
        
        repeat {
            playerAnswer = (game.choicePlayer(maxValue: maxValueRecipient)) // testing the correct anser with choicePlayer method
        }while playerAnswer == nil
        
        recipientRow = (Int(playerAnswer!)! - 1) // correcting the index for the array // index starts at 0
        game.fightTeamDisplay(dispenser: dispenserRow, recipient: recipientRow, whoseTurn: whoseTurn, spell: specialSpell) // will block the spellDeath if already used
        game.actionMenuDisplay(whoseTurn: !whoseTurn)
        
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
        
        maxValueRecipient = calculateHeroes(whoseTurn: whoseTurn, wizard: false) // so will start our possible choice by 1 for the dispensers(all heroes) possibility
        elementHeroe = 0
        
        if whoseTurn == true {
            print(" 👉 TEAM ONE \n Choose the hero to heal: ❓")
        }
        else {
            print(" 👉 TEAM TWO \n Choose the hero to heal: ❓")
        }
        
        repeat {
            playerAnswer = (game.choicePlayer(maxValue: maxValueRecipient)) // checks answer rightness
        }while playerAnswer == nil
        recipientRow = (Int(playerAnswer!)!-1) // correcting the index for the array // index starts at 0
        
        game.teamHealingDisplay(dispenser: dispenserRow, recipient: recipientRow, whoseTurn: whoseTurn)
        game.actionMenuDisplay(whoseTurn: !whoseTurn)
        
    }

    
    
    
    //==============================
    // MARK: - DISPLAY  TEAM  =
    //==============================
    
    func heroesChoiceDisplay() { // showing the choice of heroes
        
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
            + "\n           ***************************"
            + "\n           ⚡️  THE GAME: ACTION MENU *"
            + "\n           ***************************")
        
        actionTeamMenu(whoseTurn: whoseTurn) // continues by going to the method actionTeamMenu
    }
    
    func statusTeamDisplay(whoseTurn: Bool,wizard: Bool) {
        
        var array = [Heroes]()
        var emojy: String = ""
        
        array = teamFactory.status(whoseTurn: whoseTurn)
        if whoseTurn == true { // if team one has to play then we are accessing to the arrayFirstTeam
            print("\n\n           ▶️ TEAM ONE HEROES ◀️")
            emojy = "🤺" // setting the emojy for team One
        }
        else { // if team one has to play then we are accessing to the arraySecondTeam
            print("\n\n           ▶️ TEAM TWO HEROES ◀️")
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
        
        arrayDispenser = teamFactory.status(whoseTurn: whoseTurn) // setting the arrayDispenser to arrayFirstTeam
        
        arrayRecipient = teamFactory.status(whoseTurn: !whoseTurn) // setting the arrayRecipient to arraySecondTeam
        
        
        if whoseTurn == true { // if team one has to play then we are accessing to the arrayFirstTeam
            print("\n\n           ▶️ TEAM ONE HEROES ◀️")
            emojyDispenser = "🤺" // setting the emojy for the team attacking
            emojyRecipient = "🔱" // setting the emojy for the team attacked
        }
        if whoseTurn == false { // if team one has to play then we are accessing to the arraySecondTeam
            print("\n\n           ▶️ TEAM TWO HEROES ◀️")
            emojyDispenser = "🔱" // setting the emojy for the team attacking
            emojyRecipient = "🤺" // setting the emojy for the team attacked
        }
        if arrayDispenser[dispenser].type == .Wizard {
            game.teamFightWizardDisplay(dispenser: dispenser, recipient: recipient, whoseTurn: whoseTurn, spell: true)
        }
        else {
            
            print("You were attacked by:")
            game.printHeroStatus(emojy: emojyDispenser, hero: (arrayDispenser[dispenser]))
            print("Before the attack no wizard")
            game.printHeroStatus(emojy: emojyRecipient, hero: (arrayRecipient[recipient]))
            newLifeStrength = teamFactory.fight(dispenser: dispenser, recipient: recipient, whoseTurn: whoseTurn, specialSpell: !(arrayDispenser[dispenser].type != .Wizard))
            print("After the attack:")
            game.printHeroStatus(emojy: emojyRecipient, hero: (arrayRecipient[recipient]))
            
            
            if newLifeStrength == 0 {
                print("⚡️ This hero is dead!!")
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
        
        arrayDispenser = teamFactory.status(whoseTurn: whoseTurn) // setting the arrayDispenser to arrayFirstTeam
        arrayRecipient = teamFactory.status(whoseTurn: !whoseTurn) // setting the arrayRecipient to arraySecondTeam
        
        
        if whoseTurn == true { // if team one has to play then we are accessing to the arrayFirstTeam
            print("\n\n           ▶️ TEAM ONE HEROES ◀️")
            emojyDispenser = "🤺" // setting the emojy for the team attacking
            emojyRecipient = "🔱" // setting the emojy for the team attacked
        }
        if whoseTurn == false { // if team one has to play then we are accessing to the arraySecondTeam
            print("\n\n           ▶️ TEAM TWO HEROES ◀️")
            emojyDispenser = "🔱" // setting the emojy for the team attacking
            emojyRecipient = "🤺" // setting the emojy for the team attacked
        }
        
        print("\(emojyDispenser) Would you like to do a normal Spell, or using your Spell of death?")
        
        repeat {
            
            print("\n"
                + "\n What Would you like to do:"
                + "\n 1. Would you like to do normal Spell?"
                + "\n 2. Would You like to Spell of death?"
                + "\n"
                + "\n 👉 Your choice:❓")
            
            playerAnswer = (game.choicePlayer(maxValue: 2)) // checks answer rightness
            
        }while playerAnswer == nil
        
        answer = (Int(playerAnswer!)!)
        
        
        if answer == 1  { // if answer is normal spell
            print(" \(emojyRecipient) Before the attack")
            game.printHeroStatus(emojy: emojyRecipient, hero: (arrayRecipient[recipient])) // print the characters of recipient hero
            newLifeStrength = teamFactory.fight(dispenser: dispenser, recipient: recipient, whoseTurn: whoseTurn, specialSpell: false)
            print(" \(emojyRecipient) After the attack")
            game.printHeroStatus(emojy: emojyRecipient, hero: (arrayRecipient[recipient])) // print the characters of recipient hero
            if newLifeStrength == 0 { // check if hero is dead
                print(" \(emojyRecipient) Your hero \(arrayRecipient[recipient].heroName) is dead")
            }
        }
        if answer == 2  { // if answer is spell of death
            print(" \(emojyRecipient) Before the attack with spell of death")
            game.printHeroStatus(emojy: emojyRecipient, hero: (arrayRecipient[recipient])) // print the characters of recipient hero
            newLifeStrength = teamFactory.fight(dispenser: dispenser, recipient: recipient, whoseTurn: whoseTurn, specialSpell: true)
            print(" \(emojyRecipient) After the attack")
            game.printHeroStatus(emojy: emojyRecipient, hero: (arrayRecipient[recipient])) // print the characters of recipient hero
            print(" \(emojyDispenser) ⚡️ Your wizard is now having :")
            game.printHeroStatus(emojy: emojyDispenser, hero: (arrayDispenser[dispenser])) // print the characters of dispenser hero
            print(" \(emojyRecipient) Your hero \(arrayRecipient[recipient].heroName) is dead")
        }
        
    }
    
    func teamHealingDisplay(dispenser: Int, recipient: Int, whoseTurn: Bool) { // displays team is healing someone
        
        var newLifeStrength: Int
        var arrayDispenser = [Heroes]()
        var arrayRecipient = [Heroes]()
        let recipient: Int = recipient
        let dispenser: Int = dispenser
        var emojyDispenser: String = "" // emojy for the dispenser
        
        arrayDispenser = teamFactory.status(whoseTurn: whoseTurn)
        arrayRecipient = teamFactory.status(whoseTurn: whoseTurn)
        
        
        if whoseTurn == true {
            emojyDispenser = "🤺" // emojy for the dispenser
        } else {
            emojyDispenser = "🔱" // emojy for the dispense
        }
        print("The one who heals you is:")
        game.printHeroStatus(emojy: emojyDispenser, hero: (arrayDispenser[dispenser])) // print the characters of dispenser hero
        print("Before the heal Action")
        game.printHeroStatus(emojy: emojyDispenser, hero: (arrayRecipient[recipient])) // print the characters of recipient hero
        newLifeStrength = teamFactory.heal(dispenser: dispenser, recipient: recipient, whoseTurn: whoseTurn)
        print("The hero you have just heal:")
        game.printHeroStatus(emojy: emojyDispenser, hero: (arrayRecipient[recipient])) // print the characters of dispenser hero
        print("is now having: \(newLifeStrength)")
    }
    /***
    methods wich allows with random a new equipement
    ***/
    func newEquipementDisplay(whoseTurn: Bool, heroeType: HeroType, heroIndex: Int) { // method for randoming the new equipement
        
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
        
        if heroeType == .Wizard {
            arrayTeam[heroIndex].equipment = Equipment.Scepter
            print(" \(emojy) Your have a brand new Scepter")
        }
        else {
            equipementRoll = Int.random(max: 3)
            print(equipementRoll)
            
            let NewWeaponPlayer = equipementRoll
            switch NewWeaponPlayer {
            case 0 :
                
                arrayTeam[heroIndex].equipment = Equipment.Axe
                print(" \(emojy) Your new equipment is an Axe")
                
            case 1 :
                
                arrayTeam[heroIndex].equipment = Equipment.Hammer
                print(" \(emojy) Your new equipment is an Hammer")
                
            case 2 :
                
                arrayTeam[heroIndex].equipment = Equipment.Sword
                print(" \(emojy) Your new equipment is an Sword")
                
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
        
        print("\n"
            + "\n You are going to fight?")
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
        print("The game is finish")
        if teamFactory.status(whoseTurn: true).isEmpty {
            print("Team One you won!!")
        }
        else {
            print("Team Two you won!!")
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
