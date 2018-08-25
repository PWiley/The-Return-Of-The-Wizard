//
//  Team.swift
//  The Return Of The Wizard
//
//  Created by Patrick Wiley on 22/08/2018.
//  Copyright © 2018 Patrick Wiley. All rights reserved.
//

import Foundation



// declaration of dictionaryTeam [String, Heroes]
// method createTeam
// method fight
// method healing
// method statusTeam -> Team 1
//                   -> Team 2


class Team {
    
    var dictionaryTeam : [String: Heroes] = [:] // declaration of dictionaryTeam [String, Heroes]
    
    static func createTeam() { // method createTeam
        var teamName : String // It will be easy to manage
        var choicePlayer : String
        var numberOfTeam : String = "First"
        
        var numberOfPlayer : Int = 0
        
        repeat {
            print("What is the name of the "+"\(numberOfTeam)"+" team?") // Asking the name of the Team
            if let choice = readLine() {
                teamName = choice
                print("You are going to compose the Team : \(teamName)")
                
            }
            
            var numberOfHeroes : Int = 0
            
            repeat { // Asking what his player team
                print("\nWhich Heroe: number" + " \(numberOfHeroes + 1)"+", would you like to choose?")
                print("\n1. Warrior"
                    + "\n2. Dwarf"
                    + "\n3. Colossus"
                    + "\n4. Wizzard")
                choicePlayer = readLine()!
                
                switch choicePlayer {
                    
                case "1" :
                    print("Warrior")
                    numberOfHeroes += 1
                    print("you choose the Warrior")
                    
                case "2" :
                    print("Dwarf")
                    numberOfHeroes += 1
                    print("you choose the Dwarf")
                    
                case "3" :
                    print("Colossus")
                    numberOfHeroes += 1
                    print("you choose the Colossus")
                    
                case "4" :
                    print("Wizzard")
                    numberOfHeroes += 1
                    print("you choose the Wizzard")
                    
                default : print("You must choose a player")
                    
                }
                
            } while numberOfHeroes <= 3
            
            numberOfPlayer += 1
            numberOfTeam = "Second"
            
        } while numberOfPlayer < 2

        
        
    }
    
    func fight() { // method fight
    
    }
    
    func healing() { // method healing
        
    }
    
    func statusTeam() { // method statusTeam -> Team 1
                        //                   -> Team 2
    }
}
