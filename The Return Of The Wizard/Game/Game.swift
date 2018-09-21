class Game {
    
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
    
    func createTeamMenu() { /* the game will create with the two teams with that method
         We get the answer of the player // testing if the answer is acceptable */
        
        //playerTurn = "First" // property for the roll of the game
        
        var teamAlias = 0 // teamAlias will block the team creation at 2, set at begin at 0
        var teamNameAlias = "First" /* teamNameAlias is having two states -> First for the first Team
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
                    + "\n 👉 \(teamNameAlias) Team"
                    + "\n"
                    + "\n You have to choose three heroes.")
                
                repeat {
                    
                    game.heroesChoice() // printing the possible choice of heroes
                    
                    playerAnswer = game.choicePlayer(maxValue: 4) // checking if the answer is in betwwen 1 and 4
                    
                } while playerAnswer == nil
                
                var heroName: String  // that will be the name of the hero chose by the Player
                
                repeat {
                    
                    print(" 👉 How do you want to name your heroe?") // Asking the name of the Team
                    heroName = teamFactory.getHeroeName()
                    
                    
                } while heroName.isEmpty // check if no input of name which is forbidden
                
                teamFactory.composeTeam(heroeName: heroName, heroesInt: playerAnswer! ,teamNameAlias: teamNameAlias) // adding the Heroes
                print("\n"
                    + "\n 👋 hero n°\(numberOfHeroes) is created") // printing how many heroes are created
                
                numberOfHeroes += 1 // accounting one hero added
                
                
            } while numberOfHeroes < maxHeroes // check that there are only 3 heroes by team
            
            game.statusTeam(whoseTurn: true,wizard: false) // shows the status of Team two (all the heroes and not only the wizard)
            teamAlias += 1
            teamNameAlias = "Second"
            whoseTurn.toggle() // give the hand to player Two
            
            
        } while teamAlias != 2 // teamAlias is checked if the teams are already created
        
        //print("\nThank You, the Second team is created")
        game.statusTeam(whoseTurn: false,wizard: false) // shows the status of team Two (all the heroes and not only the wizard)
        whoseTurn.toggle() // give the hand to player One
//        teamFactory.NewEquipement(whoseTurn: <#T##Bool#>, heroeType: <#T##String#>, heroIndex: <#T##Int#>)
        game.actionMenu(whoseTurn: true) //
    }
    
    
    
    func actionMenu(whoseTurn: Bool) {  // give access to the main menu and will dispatch either actionFirstTeamMenu or actionSecondTeamMenu
        // based on whoseTurn(boolean true Team First/ false team Second)
        self.whoseTurn = whoseTurn
        
        print(""
            + "\n           ***************************"
            + "\n           ⚡️  THE GAME: ACTION MENU *"
            + "\n           ***************************")
        
        if whoseTurn == true { // if that is the roll of team First, then will go on actionFirstTeamMenu
            
            actionTeamMenu(whoseTurn: true)
        }
        if whoseTurn == false { // if that is the roll of team Second, then will go on actionSecondTeamMenu
            
            actionTeamMenu(whoseTurn: false)
            
        }
        
    }
    //==============================
    // MARK: - CONVERSATION  TEAM  =
    //==============================
    
    func actionTeamMenu(whoseTurn: Bool) {  // managing either fight or heal action for the First Team
        var playerAnswer: String? // that is the player answer
        var choiceGiven: Int = 0
        var turn: Bool = true
        var greetings: String = "" // greetings set at no String. will change with which have the playRoll
        var maxValueDispenser: Int = 0 // give give the number of heroes available
        var dispenserRow: Int = 0 // set the dispenserRow in the arrayTeam (First Team or Second Team depending on who have PlayRoll)
        var emojyDispenser: String = "" // declare the emojy dispenser and initialise it to empty. it will be set depending on the playRoll
        var heroType: String = "" // declaration of the type of hero variable, will allow to show to that wizard a unique power (spell of death) for all the game
        if whoseTurn == true {
            //game.statusTeam(whoseTurn: true, wizard: false) // will shows status of team One (all the heroes and not only the wizard)
            
            turn = true
            emojyDispenser = "🤺"
            greetings = "\n\n           ▶️ TEAM ONE ◀️"
            maxValueDispenser = game.statusTeam(whoseTurn: true, wizard: false) // so will start our possible choice by 1 for the dispensers possibility
            // (all the heroes and not only the wizard)
        }
        
        if whoseTurn == false {
            //game.statusTeam(whoseTurn: false, wizard: false) // will shows status of team One (all the heroes and not only the wizard)
            
            turn = false
            emojyDispenser = "🔱"
            greetings = "\n\n           ▶️ TEAM TWO ◀️"
            maxValueDispenser = game.statusTeam(whoseTurn: false, wizard: false) // so will start our possible choice by 1 for the dispensers possibility
            // (all the heroes and not only the wizard)
            
        }
//        if whoseTurn == true {
//            greetings = "\n\n           ▶️ TEAM ONE ◀️"
//            maxValueDispenser = game.statusTeam(whoseTurn: true, wizard: false) // so will start our possible choice by 1 for the dispensers possibility
//            // (all the heroes and not only the wizard)
//
//        }
//        if whoseTurn == false {
//            greetings = "\n\n           ▶️ TEAM TWO ◀️"
//            maxValueDispenser = game.statusTeam(whoseTurn: false, wizard: false) // so will start our possible choice by 1 for the dispensers possibility
//            // (all the heroes and not only the wizard)
//
//        }
        print("\(greetings)")
        print("\n 👉 Choose you hero \(emojyDispenser): ❓")
        repeat {
            playerAnswer = ((game.choicePlayer(maxValue: maxValueDispenser)))
            //                dispenserRow = (Int(playerAnswer!)! - 1) // correcting the index for the array // index starts at 0
            //print("dispenser row = \(dispenserRow)")
        }while playerAnswer == nil
        dispenserRow = (Int(playerAnswer!)! - 1) // correcting the index for the array // index starts at 0
        //            game.statusTeam(whoseTurn: true, wizard: false) // will shows status of team One (all the heroes and not only the wizard)
        //            //game.statusTeam(whoseTurn: false,wizard: false) // will shows status of team Two (all the heroes and not only the wizard)
        heroType = teamFactory.statusFactoryTeam(whoseTurn: turn, wizard: false)[dispenserRow].type
        if heroType == "Wizard" {
            
            print("⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️I am a wizard")
            
            
        }
        repeat {
            print("\n"
                + "\n What Would you like to do:"   // the game should propose First team to play with an action to do
                + "\n 1. Would you like to fight?"
                + "\n 2. Would You like to heal someone?"
                + "\n"
                + "\n 👉 Your choice:❓")
            
            playerAnswer = (game.choicePlayer(maxValue: 2)) // control if answer is correct 1 or 2 and no letters
            
        }while playerAnswer == nil // not correct answer
        choiceGiven = Int(playerAnswer!)!
        if choiceGiven == 1 { // will show the Fight menu for First Team
            fightTeamMenu(whoseTurn: turn, heroeChoice: dispenserRow)
            
        }
        if choiceGiven == 2 { // will show the Heal menu for first Team
            healTeamMenu(whoseTurn: turn, heroeChoice: dispenserRow)
        }
        //        }
        //        if whoseTurn == false {
        //
        //            game.statusTeam(whoseTurn: false, wizard: false) // will shows status of team Two (all the heroes and not only the wizard)
        //            //game.statusTeam(whoseTurn: true, wizard: false) // will shows status of team One (all the heroes and not only the wizard)
        //
        //            repeat {
        //                print("\n"
        //                    + "\n What Would you like to do:"   // the game should propose Second team to play with an action to do
        //                    + "\n 1. Would you like to fight?"
        //                    + "\n 2. Would You like to heal someone?"
        //                    + "\n"
        //                    + "\n 👉 Your choice:❓")
        //
        //                //if let choicePlayer = Int(readLine()!) { // control correct answer, here either 1 or 2 no letters accepted
        //                    playerAnswer = (game.choicePlayer(maxValue: 2)) // control if answer is correct 1 or 2 and no letters
        //                    choiceGiven = Int(playerAnswer!)!
        //              // }
        //            }while playerAnswer == nil // not correct answer
        //
        //            if choiceGiven == 1 { // will show the Fight menu for Second Team
        //                fightTeamMenu(whoseTurn: false)
        //
        //            }
        //            if choiceGiven == 2 { // will show the Heal menu for Second Team
        //                healTeamMenu(whoseTurn: false)
        //            }
        //        }
        
    }
    
    
    func fightTeamMenu(whoseTurn: Bool, heroeChoice: Int) {  /* menu for fight action for the Teams
         this menu will give him the choice of which hero he ll like to use and the opportunity to choose which hero of the opposite
         team, he ll like to attack.that menu will give him also before taking a decision the status of his team and the status of the
         opposite team */
        
        var playerAnswer: String? // the answer of the user
        let dispenserRow: Int = heroeChoice // this is the dispenser heros row
        var recipientRow: Int = 0 // this is the recipient heros row
        //var maxValueDispenser: Int = 0 // Value max for showing the heroes of dispenser team
        var maxValueRecipient: Int = 0 // Value max for showing the heroes of recipient team
        //var emojyDispenser: String = "" // emojy is declare for the dispenser
        var emojyRecipient: String = "" // emojy is declare for the recipient
        var heroType: String = "" // variable used for havinf´g the type of hero dispenser who would like to fight
        var turn: Bool = true
        var greetings: String = ""
        var specialSpell: Bool = false // property allowing to do a deathSpell for the wizard only
        //var uniqueSpell: Bool = false // property blocking the deathSpell at one time per game
        
        if whoseTurn == true {
            
//            maxValueDispenser = game.statusTeam(whoseTurn: true, wizard: false) // so will start our possible choice by 1 for the dispensers possibility
//            // (all the heroes and not only the wizard)
            //maxValueDispenser = heroeChoice
            maxValueRecipient = game.statusTeam(whoseTurn: false, wizard: false) // so will start our possible choice by 1 for the recipients possibility
            // (all the heroes and not only the wizard)
            //emojyDispenser = "🤺"
            emojyRecipient = "🔱"
            turn = true
            greetings = "\n\n           ▶️ TEAM ONE ◀️"
        }
        if whoseTurn == false {
            
//            maxValueDispenser = game.statusTeam(whoseTurn: false, wizard: false) // so will start our possible choice by 1 for the dispensers possibility
//            // (all the heroes and not only the wizard)
            
            maxValueRecipient = game.statusTeam(whoseTurn: true, wizard: false) // so will start our possible choice by 1 for the recipients possibility
            // (all the heroes and not only the wizard)
            //emojyDispenser = "🔱"
            emojyRecipient = "🤺"
            turn = false
            greetings = "\n\n           ▶️ TEAM TWO ◀️"
        }
        
        
        //            maxValueDispenser = game.statusTeam(whoseTurn: true, wizard: false) // so will start our possible choice by 1 for the dispensers possibility
        //                                                                                // (all the heroes and not only the wizard)
        //
        //            maxValueRecipient = game.statusTeam(whoseTurn: false, wizard: false) // so will start our possible choice by 1 for the recipients possibility
        //                                                                                // (all the heroes and not only the wizard)
        
//        print("\(greetings)")
//        print("\n 👉 Choose you hero \(emojyDispenser): ❓")
//        repeat {
//            playerAnswer = ((game.choicePlayer(maxValue: maxValueDispenser)))
//            //                dispenserRow = (Int(playerAnswer!)! - 1) // correcting the index for the array // index starts at 0
//            //print("dispenser row = \(dispenserRow)")
//        }while playerAnswer == nil
//        dispenserRow = (Int(playerAnswer!)! - 1) // correcting the index for the array // index starts at 0
        heroType = teamFactory.statusFactoryTeam(whoseTurn: turn, wizard: false)[dispenserRow].type
        if heroType == "Wizard" {
            
            print("⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️⚡️I am a wizard and i can do better than just striking, i can kill in one shot another hero!!!!")
            specialSpell = true // set the right to spell death
            // will block the spellDeath if already used
            
        }
        print("\(greetings)")
        print("\n 👉 Choose your opponent \(emojyRecipient): ❓")
        
        repeat {
            playerAnswer = (game.choicePlayer(maxValue: maxValueRecipient))
            //recipientRow = (Int(playerAnswer!)! - 1) // correcting the index for the array // index starts at 0
            //print("recipient row = \(recipientRow)")
        }while playerAnswer == nil
        recipientRow = (Int(playerAnswer!)! - 1) // correcting the index for the array // index starts at 0
       
        game.fightTeamDisplay(dispenser: dispenserRow, recipient: recipientRow, whoseTurn: turn, Spell: specialSpell) // will block the spellDeath if already used
       
        game.actionTeamMenu(whoseTurn: !turn)
        
        
        //        if whoseTurn == false {
        ////            maxValueDispenser = game.statusTeam(whoseTurn: false, wizard: false) // so will start our possible choice by 1 for the dispensers possibility
        ////                                                                                 // (all the heroes and not only the wizard)
        ////
        ////            maxValueRecipient = game.statusTeam(whoseTurn: true, wizard: false) // so will start our possible choice by 1 for the recipients possibility
        ////                                                                                // (all the heroes and not only the wizard)
        //
        //        }
        //        print("\n"
        //            + "\n           ▶️ TEAM TWO ◀️"
        //            + "\n 👉 choose you hero: ❓")
        //        repeat {
        //            playerAnswer = ((game.choicePlayer(maxValue: maxValueDispenser))) // checks answer rightness
        //            dispenserRow = (Int(playerAnswer!)! - 1) // correcting the index for the array // index starts at 0
        //        }while playerAnswer == nil
        //
        //        print("\n"
        //            + "\n           ▶️ TEAM TWO ◀️"
        //            + "\n 👉 Choose your opponent: ❓")
        //        repeat {
        //            playerAnswer = (game.choicePlayer(maxValue: maxValueRecipient)) // checks answer rightness
        //            recipientRow = (Int(playerAnswer!)! - 1) // correcting the index for the array // index starts at 0
        //        }while playerAnswer == nil
        //
        //        game.fightTeamDisplay(dispenser: dispenserRow, recipient: recipientRow, whoseTurn: whoseTurn)
        //        game.actionMenu(whoseTurn: true)
    }
    
    func healTeamMenu(whoseTurn: Bool, heroeChoice: Int) {  /* menu for heal action for the First Team
         if the owner of team First is having one or multiple wizzards in his team. This menu will give him the choice of which wizard he ll
         like to use and the opportunity to choose which hero, he ll like to heal.*/
        
        var playerAnswer: String? // the answer of the user
        //var dispenserRow: Int = heroeChoice // this is the dispenser heros row
        var recipientRow: Int = 0 // this is the recipient heros row
        //var maxValueDispenser: Int = 0 // Value max for showing the wizard of dispenser team
        var maxValueRecipient: Int = 0 // Value max for showing all the heroes of dispenser team
        var greetings: String = ""
        var turn: Bool = true
        
        if whoseTurn == true {
            //maxValueDispenser = (game.statusTeam(whoseTurn: true, wizard: true)) // so will start our possible choice by 1 for the dispensers(all heroes) possibility
            //print(maxValueRecipient)// so will start our possible choice by 1 for the dispensers(wizard Type only) possibility
            //print(maxValueDispenser)
            maxValueRecipient = game.statusTeam(whoseTurn: true, wizard: false) // so will start our possible choice by 1 for the dispensers(all heroes) possibility
            //print(maxValueRecipient)
            greetings = " 👉 TEAM ONE "
            turn = true
        }
        if whoseTurn == false {
            //maxValueDispenser = game.statusTeam(whoseTurn: false, wizard: true) // so will start our possible choice by 1 for the dispensers(all heroes) possibility
            //print(maxValueRecipient) // so will start our possible choice by 1 for the dispensers(wizard Type only) possibility
            //print(maxValueDispenser)
            maxValueRecipient = game.statusTeam(whoseTurn: false, wizard: false) // so will start our possible choice by 1 for the dispensers(all heroes) possibility
            //print(maxValueRecipient)
            greetings = " 👉 TEAM TWO "
            turn = false
            
        }
        
//        if maxValueDispenser == 0 {
//            print("\n"                                               // print communications for team One -> no wizard
//                + "\n ⚠️ You don't have any wizard in you team")
//            game.actionMenu(whoseTurn: turn)
//        }
//        else {
        
//            print("\(greetings)"
//                + "\n choose you wizard: ❓")
//            repeat {
//                playerAnswer = ((game.choicePlayer(maxValue: maxValueDispenser)))    // checks answer rightness
//                //dispenserRow = (Int(playerAnswer!)!-1) // correcting the index for the array // index starts at 0
//            }while playerAnswer == nil
//            dispenserRow = (Int(playerAnswer!)!-1) // correcting the index for the array // index starts at 0
            print("\(greetings)" // print communications for team One
                + "\n Choose the hero to heal: ❓")
            
            repeat {
                playerAnswer = (game.choicePlayer(maxValue: maxValueRecipient)) // checks answer rightness
                //recipientRow = (Int(playerAnswer!)!-1) // correcting the index for the array // index starts at 0
            }while playerAnswer == nil
            recipientRow = (Int(playerAnswer!)!-1) // correcting the index for the array // index starts at 0
            //game.healTeamMenu(whoseTurn: turn)
            game.teamHealingDisplay(dispenser: heroeChoice, recipient: recipientRow, whoseTurn: turn)
            //teamFactory.teamHealing(dispenser: dispenserRow, recipient: recipientRow, whoseTurn: true) // call the method teamHealing by passing all the information
            game.actionMenu(whoseTurn: !turn)
//        }
        
        
        //        if whoseTurn == false {
        //
        ////            maxValueDispenser = (game.statusTeam(whoseTurn: false, wizard: true)) // so will start our possible choice by 1 for the dispensers(wizard Type only) possibility
        ////            maxValueRecipient = game.statusTeam(whoseTurn: false, wizard: false) // so will start our possible choice by 1 for the dispensers(all heroes) possibility
        //
        //            if maxValueDispenser == 0 {
        //                print("\n"                                              // print communications for team Two -> no wizard
        //                    + "\n ⚠️ You don't have any wizard in you team")
        //                game.actionMenu(whoseTurn: turn)
        //            }
        //
        //            else {
        //
        //                print(" 👉 Second Team"
        //                    + "\n choose you wizard: ❓")
        //                repeat {
        //                    playerAnswer = ((game.choicePlayer(maxValue: maxValueDispenser)))
        //                    dispenserRow = (Int(playerAnswer!)! - 1) // correcting the index for the array // index starts at 0
        //                }while playerAnswer == nil
        //                //game.statusTeam(whoseTurn: false, wizard: false)
        //                maxValueRecipient = game.statusTeam(whoseTurn: false, wizard: false) // so will start our possible choice by 1 for the dispensers(all heroes as i decide they can heal theme self) possibility
        //                print(" 👉 Second Team"
        //                    + "\n Choose the hero to heal: ❓")
        //                repeat {
        //                    playerAnswer = (game.choicePlayer(maxValue: maxValueDispenser))
        //                    recipientRow = (Int(playerAnswer!)! - 1) // correcting the index for the array // index starts at 0
        //                }while playerAnswer == nil
        //
        //                teamFactory.teamHealing(dispenser: dispenserRow, recipient: recipientRow, whoseTurn: false)
        //                game.actionMenu(whoseTurn: true)
        //            }
        //        }
        
    }
    
    func heroesChoice() { // showing the choice of heroes
        
        print("\n Which hero would you like to choose?")
        print("\n 1. Fighter"
            + "\n 2. Wizard"
            + "\n 3. Colossus"
            + "\n 4. Dwarf"
            + "\n"
            + "\n 👉 Your choice: ❓")
    }
    //==============================
    // MARK: - DISPLAY  TEAM  =
    //==============================
    
    
    func fightTeamDisplay(dispenser: Int, recipient: Int, whoseTurn: Bool, Spell: Bool) { // Display the result of the fight
                                                                            // all fighters including wizard can fight sp wizard = false for teamFactory.statusFactoryTeam
                                                                            // Spell will manage the right of SpellDeath and uniqueSpell his uniqueness
        var arrayDispenser = [Heroes]() // array of the dispensers
        var arrayRecipient = [Heroes]() // array of the recipients
        var emojyDispenser: String = "" // emojy for the dispenser
        var emojyRecipient: String = "" // emojy for the recipient
        var turn: Bool = true // set the parameter for method teamFactory.fight
        var newLifeStrength: Int = 0
        var answer: Int = 0 // answer from the player for his choice between normal spell and death spell
        var playerAnswer: String? // Answer of the player will be checked by the method choicePlayer
        var noDeathSpell: Bool = false
        
        if whoseTurn == true { // if team one has to play then we are accessing to the arrayFirstTeam
            print(""
                + "\n           ▶️ TEAM ONE HEROES ◀️") // showing the correct communication sentences for team one
            arrayDispenser = teamFactory.statusFactoryTeam(whoseTurn: true,wizard: false) // setting the arrayDispenser to arrayFirstTeam
            arrayRecipient = teamFactory.statusFactoryTeam(whoseTurn: false,wizard: false) // setting the arrayRecipient to arraySecondTeam
            emojyDispenser = "🤺" // setting the emojy for the team attacking
            emojyRecipient = "🔱" // setting the emojy for the team attacked
            turn = true
        }
        if whoseTurn == false { // if team one has to play then we are accessing to the arraySecondTeam
            print(""
                + "\n           ▶️ TEAM TWO HEROES ◀️") // showing the correct communication sentences for team one
            arrayDispenser = teamFactory.statusFactoryTeam(whoseTurn: false,wizard: false) // setting the arrayDispenser to arraySecondTeam
            arrayRecipient = teamFactory.statusFactoryTeam(whoseTurn: true,wizard: false) //setting the arrayRecipient to arrayFirstTeam
            emojyDispenser = "🔱" // setting the emojy for the team attacking
            emojyRecipient = "🤺" // setting the emojy for the team attacked
        }
        if arrayDispenser[dispenser].type == "Wizard" {
        print("\(emojyDispenser) Would you like to do a normal Spell, or using your Spell of death?")
            
            repeat {
                
                print("\n"
                    + "\n What Would you like to do:"   // the game should propose First team to play with an action to do
                    + "\n 1. Would you like to do normal Spell?"
                    + "\n 2. Would You like to Spell of death?"
                    + "\n"
                    + "\n 👉 Your choice:❓")
                
                playerAnswer = (game.choicePlayer(maxValue: 2)) // checks answer rightness
                
            }while playerAnswer == nil
            
            answer = (Int(playerAnswer!)!)
            if answer == 1 {
                newLifeStrength = teamFactory.fight(dispenser: dispenser, recipient: recipient, whoseTurn: turn, specialSpell: false, oneSpell: false)
            }
            if answer == 2 {
                if noDeathSpell == false {
                newLifeStrength = teamFactory.fight(dispenser: dispenser, recipient: recipient, whoseTurn: turn, specialSpell: false, oneSpell: true)
                noDeathSpell = true
                }
                if noDeathSpell == true {
                    print(" \(emojyDispenser) You already did a spell of death."
                        + "\n Sorry you will be able to do a normal spell this time 😔")
                    newLifeStrength = teamFactory.fight(dispenser: dispenser, recipient: recipient, whoseTurn: turn, specialSpell: false, oneSpell: false)
                }
            }
            
            
            
            
        }
        print("\(emojyRecipient) Hit points of the attacked : \(arrayRecipient[recipient].lifeStrength)") // show differents informations
        print("\(emojyDispenser) Hit points : \(arrayDispenser[dispenser].shotStrength)")
        print("\(emojyRecipient) Protection of the shield of the attacked: \(arrayRecipient[recipient].armorStrength)") // end of the informations
        newLifeStrength = teamFactory.fight(dispenser: dispenser, recipient: recipient, whoseTurn: turn, specialSpell: Spell, oneSpell: noDeathSpell)
        if newLifeStrength == 0 {
            print("⚡️ This hero is dead!!")
        }
//        let newLifeStrength: Int = arrayRecipient[recipient].lifeStrength - (arrayDispenser[dispenser].shotStrength-arrayRecipient[recipient].armorStrength) // lifeStrenght from attacked - ( shot strenght of the attackers - armor shield of the attacked)
//        arrayRecipient[recipient].lifeStrength = newLifeStrength // setting in the array of the attacked team the new point of life at the index of the attacked
        else {
        print("⚡️ The hero you have just attacked now has these characters: \(newLifeStrength)")
        }
        
    }
    func teamHealingDisplay(dispenser: Int, recipient: Int, whoseTurn: Bool){ // team is healing someone
        var newLifeStrength: Int
        var arrayDispenser = [Heroes]()
        var arrayRecipient = [Heroes]()
        let recipient: Int = 0
        let dispenser: Int = 0
        var emojyDispenser: String = "" // emojy for the dispenser
        var turn: Bool = true
        
        
        if whoseTurn == true {
            
            arrayDispenser = teamFactory.statusFactoryTeam(whoseTurn: true, wizard: true)
            arrayRecipient = teamFactory.statusFactoryTeam(whoseTurn: true, wizard: false)
            emojyDispenser = "🤺" // emojy for the dispenser
            turn = true
            
            
            
        }
        if whoseTurn == false {
            arrayDispenser = teamFactory.statusFactoryTeam(whoseTurn: false, wizard: true)
            arrayRecipient = teamFactory.statusFactoryTeam(whoseTurn: false, wizard: false)
            
            emojyDispenser = "🔱" // emojy for the dispense
            turn = false
        }
        
        
        print("\(emojyDispenser) The life strenght of the recipients : \(arrayRecipient[recipient].lifeStrength)") // show differents informations
        print("\(emojyDispenser) Savior capacity of heal points : \(arrayDispenser[dispenser].shotStrength)")
        // end of the informations
        newLifeStrength = teamFactory.heal(dispenser: dispenser, recipient: recipient, whoseTurn: turn)
//        newLifeStrength = ((arrayDispenser[recipient].lifeStrength) + 5)
//        arrayDispenser[recipient].lifeStrength = newLifeStrength
        print(" 🤺 The hero you have just healed has now : \(newLifeStrength) points of life")
        
    }
    //        if whoseTurn == false {
    //
    //            newLifeStrength = ((teamFactory.arrayTeamSecond[recipient].lifeStrength) + 5)
    //            teamFactory.arrayTeamSecond[recipient].lifeStrength = newLifeStrength
    //            print(" 🔱 The hero you have just healed has now : \(teamFactory.arrayTeamSecond[recipient].lifeStrength) points of life")
    //        }
    //        return newLifeStrength
    
    func statusTeam(whoseTurn: Bool,wizard: Bool) -> Int {
        
        var elementHeroe: Int = 0 // number of heroes in the array for each teams
        //let wizardExist: Bool = wizard
        var array = [Heroes]()
        var emojy: String = ""
        
        if whoseTurn == true { // if team one has to play then we are accessing to the arrayFirstTeam
            print(""
                + "\n ▶️ TEAM ONE HEROES ◀️") // showing the correct communication sentences for team one
            array = teamFactory.statusFactoryTeam(whoseTurn: true,wizard: wizard)
            emojy = "🤺" // setting the emojy for team One
        }
        if whoseTurn == false { // if team one has to play then we are accessing to the arraySecondTeam
            print(""
                + "\n ▶️ TEAM TWO HEROES ◀️") // showing the correct communication sentences for team two
            array = teamFactory.statusFactoryTeam(whoseTurn: false,wizard: wizard)
            emojy = "🔱" // setting the emojy for team Two
        }
        
        for element in 0..<array.count {
            
            if wizard == true {
                
                if array[element].type == "Wizard" {
                    if array[element].alive == true { // print the alived heroes only
                        
                        print("\n\(emojy) Hero name : \(array[element].heroName)"
                            + " \(emojy) Hero Type : \(array[element].type)"
                            + "\n\(emojy) LifeStrenght : \(array[element].lifeStrength)"
                            + " \(emojy) ShotStrenght : \(array[element].shotStrength)"
                            + "\n\(emojy) ArmorStrength : \(array[element].armorStrength)"
                            + " \(emojy) Equipement : \(array[element].equipment)")
                        elementHeroe += 1
                    }
                    
                }
            }
            if wizard == false {
                
                if array[element].alive == true { // print the alived heroes only
                    
                    print("\n\(emojy) Hero name : \(array[element].heroName)"
                        + " \(emojy) Hero Type : \(array[element].type)"
                        + "\n\(emojy) LifeStrenght : \(array[element].lifeStrength)"
                        + " \(emojy) ShotStrenght : \(array[element].shotStrength)"
                        + "\n\(emojy) ArmorStrength : \(array[element].armorStrength)"
                        + " \(emojy) Equipement : \(array[element].equipment)")
                    elementHeroe += 1
                }
            }
        }
        return elementHeroe
    }
//    func statusTeamWizard(whoseTurn: Bool) -> Int { // giving information about the existence of wizard in the team on playRoll
//
//        var elementHeroe: Int = 0 // number of heroes in the array for each teams
//        var getdispenserNoWizard: Bool = true // boolean set for reducing code and having the state of wizard or not wizard
//        var turn: Bool = true
//
//        if whoseTurn == true {
//            getdispenserNoWizard = teamFactory.getDispensersTeamWithoutWizardSelected(whoseTurn: true)
//            turn = true
//        }
//        if whoseTurn == false {
//            getdispenserNoWizard = teamFactory.getDispensersTeamWithoutWizardSelected(whoseTurn: false)
//            turn = false
//
//        }
//        if getdispenserNoWizard == true {
//            elementHeroe = game.statusTeamWizard(whoseTurn: turn)
//        }
//        if getdispenserNoWizard == false {
//            print(" 😢 You don't have any wizard in your team")
//            game.actionMenu(whoseTurn: turn) // return to the action Menu because no wizard
//        }
//        return elementHeroe
    //}
    //========================
    //  MARK:  - PARAMETERS  =
    //========================
    
    func controAnswerLetters(choicePlayer: String) -> Bool { // verify that the player type the possible answer // here Two
        var correctTwo = true
        let choiceGiven = choicePlayer
        
        if choiceGiven != "y" && choiceGiven != "n" {
            correctTwo = false
        }
        return correctTwo
    }
    
    func choicePlayer(maxValue: Int) -> String? {
        
        let choicePlayer = readLine()!
        
        guard (choicePlayer.isInt) else {  // test if the answer is only Int no letters
            print("I don`t understand your answer")
            return nil
            
        }
        
        let control = controlAnswer(choicePlayer: Int(choicePlayer)!, maxValue: maxValue)
        if control { // if the answer is in between the gap of possible answers
            //print("all is perfect")
            return choicePlayer}
        else {
            print("I don`t understand your answer")
            return nil
        }
    }
    
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
