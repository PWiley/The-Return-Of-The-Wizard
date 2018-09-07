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
    var whoseTurn: String = "First" // whoseTurn ll allow to manage the roll of the game
    
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
            correctAnswer = game.controlAnswerTwoLetters(choiceplayer: choicePlayer)
            switch choicePlayer {
            case "y": print("Lets start the game")
            createTeamMenu()
            case "n": print("Too bad!! maybe next time")
            default: print("I don't understand")
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

                var choiceWeaponPlayer = ""
                repeat {
                    print("\nwhich Weapon would you like to choose?")
                    print("\n1. Axe"
                        + "\n2. Hammer"
                        + "\n3. Sword"
                        + "\n4. Scepter")
                    
                    
                    choiceWeaponPlayer = readLine()!
                    correctAnswer = game.controlAnswerFour(choicePlayer: choiceWeaponPlayer)
                } while correctAnswer == false
                teamFactory.chooseYourWeapon(heroeName: "\(heroeName)", heroesInt: "\(choicePlayer)", weaponChoice: "\(choiceWeaponPlayer)")
                
                
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
                correctAnswer = game.controlAnswerTwo(choiceplayer: choicePlayer)
                
                switch choicePlayer {
                case "1": game.statusMenu()
                case "2": game.actionMenu(whoseTurn: whoseTurn)
                default: print("I don't understand")
                    
                }
            }
        }while correctAnswer == false
        
    }
    func statusMenu() { // menu Status of teams
        var correctAnswer: Bool = true
        repeat {
        print("For which Team would you like to see the status?"
            + "\n1. First Team"
            + "\n2. Second Team")
        
        if let choicePlayer = readLine() {
            correctAnswer = game.controlAnswerTwo(choiceplayer: choicePlayer)
            switch choicePlayer {
            case "1":
                teamFactory.statusTeam(statusChoice: "First")
            case "2":
                teamFactory.statusTeam(statusChoice: "Second")
            default :
                print("I don't understand")
            }
            
        }
        } while correctAnswer == false
    }
    func actionMenu(whoseTurn: String) { // menu for the action
        // giving action choice
        //Doing an action  // testing if there is a Wizard in the team and if that is the turn of the team with it
        var gameTurn: String = whoseTurn
        print("It is the turn for Team \(gameTurn) to play")
        print("What Would you like to do:"   // the game should propose first team to start then Second team and so on
            + "\n1. Would you like to fight?"
            + "\n2. Would You like to heal someone?")
        
        if let choice = readLine() {
            
            switch choice {
            case "1": // Fighting // testing if the Heroe is a not a Wizard
                if game.whoseTurn == "First" {
                   gameTurn = "First"
                }
                if game.whoseTurn == "Second" {
                   gameTurn = "Second"
                }
                //print("You would like to fight")
                teamFactory.fight(whoseTurn: "\(gameTurn)")
                
            case "2": // Healing someone  // testing if the Heroe is  a Wizard
                
                //print("You want to heal someone")
                teamFactory.heal(whoseTurn: whoseTurn)
                
            default:
                
                print("I don't understand")
                
            }
        
        }
    }
    func controlAnswerTwo(choiceplayer: String) -> Bool { // verify that the player type the possible answer // here Two
      var correctTwo = true
        let choiceGiven = choiceplayer
        
        if choiceGiven != "1" && choiceGiven != "2" {
            correctTwo = false
        }
        return correctTwo
    }
    func controlAnswerTwoLetters(choiceplayer: String) -> Bool { // verify that the player type the possible answer // here Two
        var correctTwo = true
        let choiceGiven = choiceplayer
        
        if choiceGiven != "y" && choiceGiven != "n" {
            correctTwo = false
        }
        return correctTwo
    }
    func controlAnswerFour(choicePlayer: String) -> Bool { // verify that the player type the possible answer // here Four
        var correctFour = true
        let choiceGiven = choicePlayer
        
        if choiceGiven != "1" && choiceGiven != "2" && choiceGiven != "3" && choiceGiven != "4" {
            correctFour = false
        }
        return correctFour
    }
}

