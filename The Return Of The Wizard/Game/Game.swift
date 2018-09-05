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
        
        func gameMenu() {
            
            print("**************************************************************************************"
            + "\n*                              The Return Of The Wizard                              *"
            + "\n**************************************************************************************"
            + "\n*                                 Welome to the game                                 *"
            + "\n*                                                                                    *"
            + "\n*                                                                                    *"
            + "\n* What do you want to do ?                                                           *"
            + "\n*                                                                                    *"
            + "\n* 1. Start a new game ?                                                              *"
            + "\n* 2. Would You like to see the status of the Game ?                                  *"
            + "\n* 3. Would you like do some action ?                                                 *"
            + "\n**************************************************************************************"
            + "\n"
            + "\n"
            + "Your choice:")
            
            
        // We get the answer of the player // testing if the answer is acceptable
            
        if let choice = readLine() {
            
            repeat {
                
                switch choice {
                
            case "1": // Start a new game
                
                // asking the teamName doing that 2 times
                
                print("You decide to start a new Game")
                var teamAlias = 0
                
                
                repeat{ // will create two teams
                    
                    var numberOfHeroes : Int = 0
                    
                    
                    print("Which name would you like to give to your Team?") // Asking the name of the Team
                    
                    var teamName = teamFactory.getStarterTeam()
                    
                    if teamName == "" {
                        print("You must give a name to your Team")
                        print("Which name would you like to give to your Team?") // Asking the name of the Team
                        teamName = teamFactory.getStarterTeam()
                    }
                    else if teamName != "" {
                        teamName = teamFactory.getStarterTeam()
                        print("You give \(teamName) to your team")
                    }
                    
                    
                    
                    
                    let maxHeroes = 3
                    repeat { // Asking what his player team
                    print("You give \(teamName) to your team")
                    print("\nWhich Heroe: number \(numberOfHeroes + 1) , would you like to choose?")
                    print("\n1. Warrior"
                        + "\n2. Dwarf"
                        + "\n3. Colossus"
                        + "\n4. Wizard")
                    let choicePlayer = readLine()!
                        
                    teamFactory.composeTeam(teamName: "\(teamName)", heroesInt: "\(choicePlayer)") // adding the Heroes
                    
                    print("\nwhich Weapon would you like to choose?")
                    print("\n1. Axe"
                        + "\n2. Hammer"
                        + "\n3. Sword"
                        + "\n4. Scepter"
                        + "\n5. I don't want to choose")
                        
                    let choiceWeaponPlayer = readLine()!
                        
                    teamFactory.chooseYourWeapon(teamName: "\(teamName)", heroesInt: "\(choicePlayer)", weaponChoice: "\(choiceWeaponPlayer)")
                        
                    
                    numberOfHeroes += 1
                        
                
                    
                } while numberOfHeroes < maxHeroes
                
                
                teamAlias += 1
            
                
                } while teamAlias != 2
                
                game.gameMenu()
                
            case "2": // see the status of the Game
                
                print("The status of the game")
                    
                teamFactory.statusTeam()
                game.gameMenu()
                
            case "3": // Doing an action  // testing if there is a Wizard in the team and if that is the turn of the team with it
                
                print("What Would you like to do:"
                    + "\n1. Would you like to fight?"
                    + "\n2. Would You like to heal someone?")
                
                if let choice = readLine() {
                    
                    switch choice {
                    case "1": // Fighting // testing if the Heroe is a not a Wizard
                        
                        //print("You would like to fight")
                        teamFactory.fight()
                        
                    case "2": // Healing someone  // testing if the Heroe is  a Wizard
                        
                        //print("You want to heal someone")
                        teamFactory.healing()
                        
                    default:
                        
                        print("I don't understand")
                        game.gameMenu()
                    }
                }
            default:
                print("I don't understand")
                game.gameMenu()
            
        }
                
            }while choice == "1" || choice == "2" || choice == "3"
            
}
        
}

        


}
