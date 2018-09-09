//
//  Game.swift
//  The Return Of The Wizard
//
//  Created by Patrick Wiley on 22/08/2018.
//  Copyright © 2018 Patrick Wiley. All rights reserved.
//

import Foundation


// method menu
// method giveInfo -> before game
//                 -> after game
// method giveTheResult

// What the player do call method create game from class Team
//                         method fight from class team
//                         method healing from class Team
//                         method statusTeam -> Team 1
//                                           -> Team 2

// setting here the game:

//Welcome of the players
//What do you want to do?
//Start a new game / Fight
//If start a new game   // Ask the team name
// Ask the Player name
// Ask Choice heroes (Three times) // Ask the Heroe Name
// Show the status of the team

//If start a fight      // Showing the team status
// Do you want to attack or heal someone
// If Attacking     // which heroe would you like to be?
// Which Fighter of the other team would you like to attack?
// Show the result of the fight
// If healing // Which heroe would you like to heal?
// method gameMenu


class Game {
    
    init() {}
    
    let teamFactory = TeamFactory()
    var whoseTurn: Int = 0 // whoseTurn is initialized at 0 so Team First will start choosing action either fighting or healing
    
    func gameStartMenu() {
        var correctAnswer: Bool = true
        repeat {
            print("**************************************************************************************"
                + "\n*                              The Return Of The Wizard                              *"
                + "\n**************************************************************************************"
                + "\n*                                 Welome to the game                                 *"
                + "\n*                                                                                    *"
                + "\n**************************************************************************************"
                + "\n"
                + "\nStart a new game? :Yes(y) / No(n)?"
                + "\nYour choice:")
            if let choicePlayer = readLine() {
                
                correctAnswer = game.controlAnswerTwoLetters(choicePlayer: choicePlayer)
                switch choicePlayer {
                case "y":
                    print("Lets start the game")
                    createTeamMenu()
                    
                case "n":
                    print("Too bad!! maybe next time")
                default:
                    print("I don't understand")
                }
            }
        }while correctAnswer == false
    }
    
    func createTeamMenu() {
        // We get the answer of the player // testing if the answer is acceptable
        
        //playerTurn = "First" // property for the roll of the game
        
        // asking the teamName doing that 2 times
        
        //print("You decide to start a new Game")
        var teamAlias = 0
        var teamNameAlias = "First"
        
        
        repeat{ // will create two teams
            var correctAnswer: Bool = true
            var numberOfHeroes : Int = 0
            let maxHeroes = 3
            repeat { // create the Teams
                print("You are creating the \(teamNameAlias) Team")
                print("How do you want to name your heroe?") // Asking the name of the Team
                
                let heroeName = teamFactory.getHeroeName()
                
                var choicePlayer: String = ""
                //print("You give \(heroeName) to your Heroe")
                
                repeat {
                    print("\nWhich Heroe: number \(numberOfHeroes + 1) , would you like to choose?")
                    print("\n1. Warrior"
                        + "\n2. Dwarf"
                        + "\n3. Colossus"
                        + "\n4. Wizard")
                    choicePlayer = readLine()!
                    correctAnswer = game.controlAnswerFour(choicePlayer: choicePlayer)
                    
                } while correctAnswer == false
                teamFactory.composeTeam(heroeName: "\(heroeName)", heroesInt: "\(choicePlayer)",teamNameAlias: "\(teamNameAlias)") // adding the Heroes
                
                //                var choiceWeaponPlayer = ""
                //                repeat {
                //                    print("\nwhich Weapon would you like to choose?")
                //                    print("\n1. Axe"
                //                        + "\n2. Hammer"
                //                        + "\n3. Sword"
                //                        + "\n4. Scepter")
                //
                //
                //                    choiceWeaponPlayer = readLine()!
                //                    correctAnswer = game.controlAnswerFour(choicePlayer: choiceWeaponPlayer)
                //                } while correctAnswer == false
                //teamFactory.chooseYourWeapon(heroeName: "\(heroeName)", heroesInt: "\(choicePlayer)", weaponChoice: "\(choiceWeaponPlayer)")
                
                
                numberOfHeroes += 1
                
                
                
            } while numberOfHeroes < maxHeroes
            
            
            teamAlias += 1
            teamNameAlias = "Second"
            
            
        } while teamAlias != 2
        game.mainMenu()
    }
    
    func mainMenu() { // prints the choice between statusMenu and actionMenu
        var correctAnswer: Bool = true
        
        repeat {
            print("**************************************************************************************"
                + "\n*                              The Return Of The Wizard                              *"
                + "\n**************************************************************************************"
                + "\n*                                                                                    *"
                + "\n*                                                                                    *"
                + "\n* 1. Would You like to see the status of the Game ?                                  *"
                + "\n* 2. Would you like to do some action ?                                              *"
                + "\n**************************************************************************************"
                + "\n"
                + "\n"
                + "Your choice:")
            if let choicePlayer = readLine() {
                correctAnswer = game.controlAnswerTwo(choicePlayer: choicePlayer)
                
                switch choicePlayer {
                case "1": game.statusMenu()
                case "2": game.actionMenu(arrayStatusTeamFirst: teamFactory.statusTeam().0, arrayStatusTeamSecond: teamFactory.statusTeam().1)
                default: print("I don't understand")
                    
                }
            }
        }while correctAnswer == false
        
    }
    func statusMenu() { // menu Status of teams
        
            print("Here is the status of First Team")
        
            print(teamFactory.statusTeam().0) // print arrayStatusTeamFirst
 
            print("Here is the status of Second Team")
       
            print(teamFactory.statusTeam().1) // print arrayStatusTeamSecond
        

            }
    
    
    
    func actionMenu(arrayStatusTeamFirst: [Heroes], arrayStatusTeamSecond: [Heroes]){ // menu for the action
        var correctAnswer: Bool = true
        
        print("That is the status of the game")
        
        //print("For Team First:")
        
        for element in 0..<arrayStatusTeamFirst.count { // give the info for team One
            print(arrayStatusTeamFirst[element].type)
        }
        for element in 0..<arrayStatusTeamSecond.count { // give the info for team Two
            print(arrayStatusTeamSecond[element].type)
        }
        var rollGame: Int = 0
        var playerTurn: String = ""
        repeat {
            
            let modulo = rollGame%2
            if modulo == 0 {
                playerTurn = "First"
            }
            if modulo == 1 {
                playerTurn = "Second"
            }
        print("It is the turn for Team \(playerTurn) to play") // gameturn -> modulo
        print("What Would you like to do:"   // the game should propose first team to start then Second team and so on
            + "\n1. Would you like to fight?"
            + "\n2. Would You like to heal someone?")
       
            
        if let choice = readLine() {
            
//            var dispenserAlias: Int = 0 // dispensers row
//            var recipientAlias: Int = 0 // recipients row
            
            switch choice {
            case "1": // Fighting //
                
                if modulo == 0 {
                    var dispenserRow: Int = 0
                    print("First Team you have these fighters that you can choose: ")
                    for elementDispensers in 0..<arrayStatusTeamFirst.count {
                        print("\n\(elementDispensers) \(teamFactory.getDispensersTeam(playerTurn: "First", heroeRow: elementDispensers))")
                        dispenserRow = elementDispensers
                    }
                    
                    if dispenserRow == 0 {
                        repeat {
                            
                            if let choiceDispenser = Int(readLine()!) {
                                let valueRow = "1"
                                correctAnswer = game.controlAnswerOne(choicePlayer: valueRow)
                                dispenserRow = choiceDispenser
                            }
                        }while correctAnswer == false
                    
                    }
                    if dispenserRow == 1 {
                        repeat {
                            
                            if let choiceDispenser = Int(readLine()!) {
                                let valueRow = "2"
                                correctAnswer = game.controlAnswerTwo(choicePlayer: valueRow)
                                dispenserRow = choiceDispenser
                            }
                        }while correctAnswer == false
                        
                    }
                    if dispenserRow == 2 {
                        repeat {
                            
                            if let choiceDispenser = Int(readLine()!) {
                                let valueRow = "3"
                                correctAnswer = game.controlAnswerThree(choicePlayer: valueRow)
                                dispenserRow = choiceDispenser
                            }
                        }while correctAnswer == false
                        
                    }
                    print("You can choose these heroes to attack: ")
                    
                    var recipientRow: Int = 0
                    
                    for elementRecipients in 0..<arrayStatusTeamSecond.count {
                        print("\n\(elementRecipients) \(teamFactory.getRecipientsTeam(playerTurn: "Second", heroeRow: elementRecipients))")
                        recipientRow = elementRecipients
                    }
                    if recipientRow == 0 {
                        repeat {
                            
                            if let choiceRecipient = Int(readLine()!) {
                                let valueRow = "1"
                                correctAnswer = game.controlAnswerOne(choicePlayer: valueRow)
                                recipientRow = choiceRecipient
                            }
                        }while correctAnswer == false
                      
                    }
                    if recipientRow == 1 {
                        repeat {
                            
                            if let choiceRecipient = Int(readLine()!) {
                                let valueRow = "2"
                                correctAnswer = game.controlAnswerTwo(choicePlayer: valueRow)
                                recipientRow = choiceRecipient
                            }
                        }while correctAnswer == false
                       
                    }
                    if recipientRow == 2 {
                        repeat {
                            
                            if let choiceRecipient = Int(readLine()!) {
                                let valueRow = "3"
                                correctAnswer = game.controlAnswerThree(choicePlayer: valueRow)
                                recipientRow = choiceRecipient
                            }
                        }while correctAnswer == false
                       
                    }
                    //print("With which Fighter would you like to attack?:")
                    
                    
                    teamFactory.fight(dispenser: dispenserRow, recipient: recipientRow, dispenserTeam: "First")
                }
                
                
                
                
                
                if modulo == 1 {
                    var dispenserRow: Int = 0
                    print("Second Team you have these fighters that you can choose: ")
                    for elementDispensers in 0..<arrayStatusTeamSecond.count {
                        print("\n\(elementDispensers) \(teamFactory.getDispensersTeam(playerTurn: "Second", heroeRow: elementDispensers))")
                        dispenserRow = elementDispensers
                    }
                    if dispenserRow == 0 {
                        repeat {
                            
                            if let choiceDispenser = Int(readLine()!) {
                                let valueRow = "1"
                                correctAnswer = game.controlAnswerOne(choicePlayer: valueRow)
                                dispenserRow = choiceDispenser
                            }
                        }while correctAnswer == false
                        
                    }
                    if dispenserRow == 1 {
                        repeat {
                            
                            if let choiceDispenser = Int(readLine()!) {
                                let valueRow = "2"
                                correctAnswer = game.controlAnswerTwo(choicePlayer: valueRow)
                                dispenserRow = choiceDispenser
                            }
                        }while correctAnswer == false
                        
                    }
                    if dispenserRow == 2 {
                        repeat {
                            
                            if let choiceDispenser = Int(readLine()!) {
                                let valueRow = "3"
                                correctAnswer = game.controlAnswerThree(choicePlayer: valueRow)
                                dispenserRow = choiceDispenser
                            }
                        }while correctAnswer == false
                        
                    }
                    print("You can choose these heroes to attack: ")
                    
                    var recipientRow: Int = 0
                    
                    for elementRecipients in 0..<arrayStatusTeamFirst.count {
                        print("\n\(elementRecipients) \(teamFactory.getRecipientsTeam(playerTurn: "First", heroeRow: elementRecipients))")
                        recipientRow = elementRecipients
                    }
                    if recipientRow == 0 {
                        repeat {
                            
                            if let choiceRecipient = Int(readLine()!) {
                                let valueRow = "1"
                                correctAnswer = game.controlAnswerOne(choicePlayer: valueRow)
                                recipientRow = choiceRecipient
                            }
                        }while correctAnswer == false
                        
                    }
                    if recipientRow == 1 {
                        repeat {
                            
                            if let choiceRecipient = Int(readLine()!) {
                                let valueRow = "2"
                                correctAnswer = game.controlAnswerTwo(choicePlayer: valueRow)
                                recipientRow = choiceRecipient
                            }
                        }while correctAnswer == false
                        
                    }
                    if recipientRow == 2 {
                        repeat {
                            
                            if let choiceRecipient = Int(readLine()!) {
                                let valueRow = "3"
                                correctAnswer = game.controlAnswerThree(choicePlayer: valueRow)
                                recipientRow = choiceRecipient
                            }
                        }while correctAnswer == false
                        
                    }
                    
                    teamFactory.fight(dispenser: dispenserRow, recipient: recipientRow, dispenserTeam: "Second")
                }
                
                
                
            case "2": // Healing someone  // testing if the Heroe is  a Wizard
                
                if modulo == 0 { // check if there is a wizard in team First
                    
                    var dispenserRow: Int = 0
                    print("First Team you have this/these Wizard(s) that you can choose: ")
                    for elementDispensers in 0..<arrayStatusTeamFirst.count {
                        print("\n\(elementDispensers) \(teamFactory.getDispensersTeam(playerTurn: "First", heroeRow: elementDispensers))")
                        dispenserRow = elementDispensers
                    }
                    if dispenserRow == 0 {
                        repeat {
                            
                            if let choiceDispenser = Int(readLine()!) {
                                let valueRow = "1"
                                correctAnswer = game.controlAnswerOne(choicePlayer: valueRow)
                                dispenserRow = choiceDispenser
                            }
                        }while correctAnswer == false
                        
                    }
                    if dispenserRow == 1 {
                        repeat {
                            
                            if let choiceDispenser = Int(readLine()!) {
                                let valueRow = "2"
                                correctAnswer = game.controlAnswerTwo(choicePlayer: valueRow)
                                dispenserRow = choiceDispenser
                            }
                        }while correctAnswer == false
                        
                    }
                    if dispenserRow == 2 {
                        repeat {
                            
                            if let choiceDispenser = Int(readLine()!) {
                                let valueRow = "3"
                                correctAnswer = game.controlAnswerThree(choicePlayer: valueRow)
                                dispenserRow = choiceDispenser
                            }
                        }while correctAnswer == false
                        
                    }
                    
                    
                    print("You can heal these heroes: ")
                    
                    var recipientRow: Int = 0
                    //let elementDispensers: Int = 0
                    var arrayWithoutWizard = [Heroes]()
                    for elementDispensers in 0..<arrayStatusTeamFirst.count {
                        if arrayStatusTeamFirst[dispenserRow].heroeName != arrayStatusTeamFirst[recipientRow].heroeName {
                            
                          arrayWithoutWizard = teamFactory.getDispensersTeamWithoutWizardSelected(element: recipientRow, playerTurn: "First")
                            
                            
                        }
                        
                        recipientRow = elementDispensers
                        //recipientRow = elementDispensers
                    }
                    for element in 0..<arrayWithoutWizard.count {
                        print(arrayWithoutWizard[element].type)
                    }
                    if recipientRow == 0 {
                        repeat {
                            
                            if let choiceRecipient = Int(readLine()!) {
                                let valueRow = "1"
                                correctAnswer = game.controlAnswerOne(choicePlayer: valueRow)
                                recipientRow = choiceRecipient
                            }
                        }while correctAnswer == false
                        
                    }
                    if recipientRow == 1 {
                        repeat {
                            
                            if let choiceRecipient = Int(readLine()!) {
                                let valueRow = "2"
                                correctAnswer = game.controlAnswerTwo(choicePlayer: valueRow)
                                recipientRow = choiceRecipient
                            }
                        }while correctAnswer == false
                        
                    }
                    if recipientRow == 2 {
                        repeat {
                            
                            if let choiceRecipient = Int(readLine()!) {
                                let valueRow = "3"
                                correctAnswer = game.controlAnswerThree(choicePlayer: valueRow)
                                recipientRow = choiceRecipient
                            }
                        }while correctAnswer == false
                        
                    }
                    
                    teamFactory.heal(dispenser: dispenserRow, recipient: recipientRow, dispenserTeam: "First")
                }
                
                
                if modulo == 1 {
                    var dispenserRow: Int = 0
                    print("First Team you have this/these Wizard(s) that you can choose: ")
                    for elementDispensers in 0..<arrayStatusTeamFirst.count {
                        print("\n\(elementDispensers) \(teamFactory.getDispensersTeam(playerTurn: "Second", heroeRow: elementDispensers))")
                        dispenserRow = elementDispensers
                    }
                    if dispenserRow == 0 {
                        repeat {
                            
                            if let choiceDispenser = Int(readLine()!) {
                                let valueRow = "1"
                                correctAnswer = game.controlAnswerOne(choicePlayer: valueRow)
                                dispenserRow = choiceDispenser
                            }
                        }while correctAnswer == false
                        
                    }
                    if dispenserRow == 1 {
                        repeat {
                            
                            if let choiceDispenser = Int(readLine()!) {
                                let valueRow = "2"
                                correctAnswer = game.controlAnswerTwo(choicePlayer: valueRow)
                                dispenserRow = choiceDispenser
                            }
                        }while correctAnswer == false
                        
                    }
                    if dispenserRow == 2 {
                        repeat {
                            
                            if let choiceDispenser = Int(readLine()!) {
                                let valueRow = "3"
                                correctAnswer = game.controlAnswerThree(choicePlayer: valueRow)
                                dispenserRow = choiceDispenser
                            }
                        }while correctAnswer == false
                        
                    }
                    
                    
                    print("You can heal these heroes: ")
                    
                    var recipientRow: Int = 0
                    //let elementDispensers: Int = 0
                    var arrayWithoutWizard = [Heroes]()
                    for elementDispensers in 0..<arrayStatusTeamFirst.count {
                        if arrayStatusTeamFirst[dispenserRow].heroeName != arrayStatusTeamFirst[recipientRow].heroeName {
                            
                         arrayWithoutWizard = teamFactory.getDispensersTeamWithoutWizardSelected(element: recipientRow, playerTurn: "Second")
                            
                            
                        }
                        
                        recipientRow = elementDispensers
                        //recipientRow = elementDispensers
                    }
                    for element in 0..<arrayWithoutWizard.count {
                        print(arrayWithoutWizard[element].type)
                        recipientRow = element
                    }
                    if recipientRow == 0 {
                        repeat {
                            
                            if let choiceRecipient = Int(readLine()!) {
                                let valueRow = "1"
                                correctAnswer = game.controlAnswerOne(choicePlayer: valueRow)
                                recipientRow = choiceRecipient
                            }
                        }while correctAnswer == false
                        
                    }
                    if recipientRow == 1 {
                        repeat {
                            
                            if let choiceRecipient = Int(readLine()!) {
                                let valueRow = "2"
                                correctAnswer = game.controlAnswerTwo(choicePlayer: valueRow)
                                recipientRow = choiceRecipient
                            }
                        }while correctAnswer == false
                        
                    }
                    if recipientRow == 2 {
                        repeat {
                            
                            if let choiceRecipient = Int(readLine()!) {
                                let valueRow = "3"
                                correctAnswer = game.controlAnswerThree(choicePlayer: valueRow)
                                recipientRow = choiceRecipient
                            }
                        }while correctAnswer == false
                        
                    }
                    teamFactory.heal(dispenser: dispenserRow, recipient: recipientRow, dispenserTeam: "First")
                }
                
                
            default:
                
                print("I don't understand")
                
            
            rollGame += 1
            }
        }
}while arrayStatusTeamFirst.count != 0 || arrayStatusTeamSecond.count != 0
    }
        
    
//    func fightMenu() -> Int {
//        
//        // need the content of team depending of whoseturn
//        
//        return whoseTurn
//    }
//    func healMenu() -> Int {
//        // need the content of team depending of whoseturn
//        return whoseTurn
//    }
    func controlAnswerOne(choicePlayer: String) -> Bool { // verify that the player type the possible answer // here One
        var correctOne = true
        let choiceGiven = choicePlayer
        
        if choiceGiven != "1" {
            correctOne = false
        }
        return correctOne
    }
    func controlAnswerTwo(choicePlayer: String) -> Bool { // verify that the player type the possible answer // here Two
        var correctTwo = true
        let choiceGiven = choicePlayer
        
        if choiceGiven != "1" && choiceGiven != "2" {
            correctTwo = false
        }
        return correctTwo
    }
    func controlAnswerThree(choicePlayer: String) -> Bool { // verify that the player type the possible answer // here Two
        var correctThree = true
        let choiceGiven = choicePlayer
        
        if choiceGiven != "1" && choiceGiven != "2" && choiceGiven != "3"{
            correctThree = false
        }
        return correctThree
    }
    
    func controlAnswerFour(choicePlayer: String) -> Bool { // verify that the player type the possible answer // here Four
        var correctFour = true
        let choiceGiven = choicePlayer
        
        if choiceGiven != "1" && choiceGiven != "2" && choiceGiven != "3" && choiceGiven != "4" {
            correctFour = false
        }
        return correctFour
    }
    
    func controlAnswerTwoLetters(choicePlayer: String) -> Bool { // verify that the player type the possible answer // here Two
        var correctTwo = true
        let choiceGiven = choicePlayer
        
        if choiceGiven != "y" && choiceGiven != "n" {
            correctTwo = false
        }
        return correctTwo
    }
    //    func getFightersType(whoseTurn: String, sortAction: String) {
    //
    //        // case one if whoseTurn == "First"      attackers are team First   and defendants are Team Second
    //        if whoseTurn == "First" {
    //
    //            if sortAction == "Fight" {
    //
    //            print("You can chose these Heroes for attacking")
    //            teamFactory.getDispensersTeam(whoseTurn: "First", sortAction: "Fight")
    //
    //            print("You can attack these Heroes")
    //            teamFactory.getRecipientsTeam(whoseTurn: "First", sortAction: "Fight")
    //            }
    //            if sortAction == "Heal" {
    //
    //            print("You can chose these Heroes for healing")
    //            teamFactory.getDispensersTeam(whoseTurn: "First", sortAction: "Heal")
    //
    //            print("You can Heal these Heroes")
    //            teamFactory.getRecipientsTeam(whoseTurn: "First", sortAction: "Heal")
    //
    //            }
    //
    //        }
    //
    //        // case two if whoseTurn == "Second"     attakers are team Second   and defendants are Team First
    //        if whoseTurn == "Second" {
    //            print("You can chose these Heroes for attacking")
    //            teamFactory.getDispensersTeam(whoseTurn: "Second", sortAction: "Fight")
    //
    //            print("You can attack these Heroes")
    //            teamFactory.getRecipientsTeam(whoseTurn: "First", sortAction: "Fight")
    //
    //
    //        }
    //
    //    }
//    func whoseTurn(playerTurn: Int) -> (Int,Int) {
//        var whoseTurn = playerTurn
//        var numberTurn: Int
//        whoseTurn = playerTurn % 2
//        numberTurn += 1
//        print("\(whoseTurn)")
//        return (whoseTurn,numberTurn)
//    }
}

