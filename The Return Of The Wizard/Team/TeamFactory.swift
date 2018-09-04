//
//  TeamFactory.swift
//  The Return Of The Wizard
//
//  Created by Patrick Wiley on 30/08/2018.
//  Copyright © 2018 Patrick Wiley. All rights reserved.
//

import Foundation


class TeamFactory {
    
    
    let teamFactory = Team()
    
    
    func getStarterTeam() -> String{ // create the teamName
        
        var teamName = ""
        
        if let choicePlayer = readLine(){
        teamName = choicePlayer
        }
        return teamName
        
    }
    
    
    func composeTeam(teamName : String, heroesInt: String) -> Int{ // method createTeam
        
        let team = Team()
        let choicePlayer = heroesInt
        print(choicePlayer)
        teamFactory.arrayTeam.append(HeroesFactory().getHeroe(heroesInt: choicePlayer)!)
        //var arrayTeam = team.arrayTeam
        print("We have: \(teamFactory.arrayTeam.count) Heroes in the array of teams")
        return teamFactory.arrayTeam.count
        
    }
//    func statusTeam(team: Team) {
//        
//        let index = team.arrayTeam.count
//        print("that is the status of the team")
//        print("I am in the StatusTeam method")
//       
//        print("We have: \(index) Heroes in the array of teams")
//        print(index)    //should print the arrayTeam content
//        
//        
//        
//    }
    func healing() {}
    func fight() {}
    
}


