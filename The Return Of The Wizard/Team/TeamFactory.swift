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
    let heroesFactory = HeroesFactory()
    let team = Team()
    
    func getStarterTeam() -> String{ // create the teamName
        
        var teamName = ""
        
        if let choicePlayer = readLine(){
        teamName = choicePlayer
        }
        return teamName
        
    }
    
    
    func composeTeam(teamName : String, heroesInt: String){ // method createTeam
        
        
        let choicePlayer = heroesInt
        let name = teamName
        let heroe = heroesFactory.getHeroe(heroesInt: choicePlayer)!
        heroe.teamName = name
        teamFactory.arrayTeam.append(heroe)
        print("We have: \(teamFactory.arrayTeam.count) Heroes in the array of teams")
        print(teamFactory.arrayTeam)
        //let arrayTeamFactory = teamFactory.arrayTeam
        
    }
    func statusTeam() {
        
        
        print("that is the content of teamFactory.arrayTeam \(teamFactory.arrayTeam)")
        
        for element in 0..<teamFactory.arrayTeam.count {
//            print("LifeStregth : \(teamFactory.arrayTeam[element].lifeStrength)")
//            print("ShotStrength : \(teamFactory.arrayTeam[element].shotStrength)")
//            print("ArmorStrength : \(teamFactory.arrayTeam[element].armorStrength)")
//            print("Name : \(teamFactory.arrayTeam[element].name)")
//            print("TeamName : \(teamFactory.arrayTeam[element].teamName)")
            print("We have in Team  \(teamFactory.arrayTeam[element].teamName) :  A  \(teamFactory.arrayTeam[element].name) : with lifeStrength: \(teamFactory.arrayTeam[element].lifeStrength) and a shotStrength : \(teamFactory.arrayTeam[element].shotStrength) protected by \(teamFactory.arrayTeam[element].armorStrength) of armorStrength")
            
        }
       
//        print("We have: \(index) Heroes in the array of teams")
//        print(index)    //should print the arrayTeam content
        
        
        
    }
    func healing() {}
    func fight() {}
    
}


