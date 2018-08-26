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

    //: Playground - noun: a place where people can play
    
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
    // If healing // Which heroe would like to heal?
    class Game {
        
        init() {}
        
        static func gameMenu() {
            
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
        // We get the answer of the player
        if let choice = readLine() {
            switch choice {
            case "1": // Start a new game
                print("\n"
                     + "\nYou decide to create a team")
                
                    Team.createTeam()
                
            case "2": // see the status of the Game
                
                    print("The status of the game")
                    Team.statusTeam()
                
            case "3": // Doing an action
                
                print("What Would you like to do:"
                    + "\n1. Would you like to fight?"
                    + "\n2. Would You like to heal someone?")
                
                if let choice = readLine() {
                    
                    switch choice {
                    case "1": // Fighting
                        
                        print("You would like to fight")
                        
                    case "2": // Healing someone
                        
                        print("You want to heal someone")
                        
                    default:
                        
                        print("I don't understand")
                    }
                }
            default:
                print("I don't understand")
            }
        }
    }
 
}

