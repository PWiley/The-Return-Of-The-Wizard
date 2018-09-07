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
    
    func getHeroeName() -> String{ // create the heroeName
        
        var nameUnique: Bool = true
        var heroeName: String = ""
        var choicePlayer: String
        repeat {
            
            choicePlayer = readLine()!
            nameUnique = checkUniqueNameHeroe(heroeNameGiven : choicePlayer)
            
            
        }while nameUnique == false
        heroeName = choicePlayer
        return heroeName
        
    }
    
    
    func composeTeam(heroeName : String, heroesInt: String, teamNameAlias: String) { // method createTeam
        
        
        let choicePlayer = heroesInt
        let heroe = heroesFactory.getHeroe(heroesInt: choicePlayer)!
        heroe.heroeName = heroeName
        heroe.teamNameAlias = teamNameAlias
        teamFactory.arrayTeam.append(heroe)
        //print("We have: \(teamFactory.arrayTeam.count) Heroes in the array of teams")
        print(teamFactory.arrayTeam)
        print(heroe.teamNameAlias)
        
    }
    
    func chooseYourWeapon(heroeName : String, heroesInt: String, weaponChoice: String) { // method for choosing the Weapon // First not possible
        
        let choicePlayer = heroesInt
        let name = heroeName
        
        let choiceWeaponPlayer = weaponChoice
        switch choiceWeaponPlayer {
        case "1" :
            
            let equipment = Equipment.Axe
            let equipmentEffect = equipment.rawValue // Printing the value of Axe
            print("The effect of your equipment is \(equipmentEffect)")
            
            let heroe = heroesFactory.getHeroe(heroesInt: choicePlayer)!
            heroe.heroeName = name
            heroe.equipment = equipment
            
            
        case "2" :
            
            let equipment = Equipment.Hammer
            let equipmentEffect = equipment.rawValue // Printing the value of Hammer
            print("The effect of your equipment is \(equipmentEffect)")
            
            let heroe = heroesFactory.getHeroe(heroesInt: choicePlayer)!
            heroe.heroeName = name
            heroe.equipment = equipment
            
        case "3" :
            
            let equipment = Equipment.Sword
            let equipmentEffect = equipment.rawValue // Printing the value of Sword
            print("The effect of your equipment is \(equipmentEffect)")
            
            let heroe = heroesFactory.getHeroe(heroesInt: choicePlayer)!
            heroe.heroeName = name
            heroe.equipment = equipment
            
        case "4" :
            
            let equipment = Equipment.Scepter
            let equipmentEffect = equipment.rawValue // Printing the value of Scepter
            print("The effect of your equipment is \(equipmentEffect)")
            
            let heroe = heroesFactory.getHeroe(heroesInt: choicePlayer)!
            heroe.heroeName = name
            heroe.equipment = equipment
            
        case "5" :
            
            let heroe = heroesFactory.getHeroe(heroesInt: choicePlayer)!
            heroe.heroeName = name
            
        default : print("You must choose a Weapon")
            
        }
        
        
        
        
    }
    func statusTeam(statusChoice: String) {
        
        let teamAlias = statusChoice
        print("that is the content of teamFactory.arrayTeam \(teamFactory.arrayTeam)")
        
        for element in 0..<teamFactory.arrayTeam.count {
            
            if teamFactory.arrayTeam[element].teamNameAlias == teamAlias {
                print("We have the player of type\(teamFactory.arrayTeam[element].heroeName) in Team  \(teamFactory.arrayTeam[element].teamNameAlias)")
                
            }
            if teamFactory.arrayTeam[element].teamNameAlias == teamAlias {
                print("We have the player of type\(teamFactory.arrayTeam[element].heroeName) in Team  \(teamFactory.arrayTeam[element].teamNameAlias)")
                
            }
            //  print("We have in Team  \(teamFactory.arrayTeam[element].heroeName) :  A  \(teamFactory.arrayTeam[element].name) : with lifeStrength: \(teamFactory.arrayTeam[element].lifeStrength) and a shotStrength : \(teamFactory.arrayTeam[element].shotStrength) protected by \(teamFactory.arrayTeam[element].armorStrength) of armorStrength, is having \(teamFactory.arrayTeam[element].equipment) as an equipment")
        }
        
        //        print("We have: \(index) Heroes in the array of teams")
        //        print(index)    //should print the arrayTeam content
        
        
        
    }
    func healing() {
        
        if teamFactory.arrayTeam.isEmpty { // testing if the teams are created
            print("You must create two teams")
            game.createTeamMenu()
        }
        for element in 0..<teamFactory.arrayTeam.count {
            if teamFactory.arrayTeam[element].type == "Wizard" {
                print("You would like to heal someone")
            }
        }
    }
    func fight() {
        if teamFactory.arrayTeam.isEmpty { // testing if the teams are created
            print("You must create two teams")
            game.createTeamMenu()
        }
        else {
            print("You would like to fight against someone")
        }
    }
    func checkUniqueNameHeroe(heroeNameGiven : String) -> Bool {
        var unique: Bool = true
        let heroeNameEnter = heroeNameGiven
        
        for element in 0..<teamFactory.arrayTeam.count {
            if heroeNameEnter == teamFactory.arrayTeam[element].heroeName {
                print("There is already an Heroe with that name")
                print("Give another name to your Heroe")
                unique = false
            }
            
            
        }
        
        return unique
    }
    func checkNumberPlayerFirstTeam()-> Int {
        var numberHeroesFirst: Int = 0 // number of heroes in First Team
        
        for element in 0..<teamFactory.arrayTeam.count { // counting number of heroes in First Team
            if teamFactory.arrayTeam[element].teamNameAlias == "first" { // counting number of heroes in First Team
                numberHeroesFirst += 1
            }
            
        }
        return numberHeroesFirst
    }
    func checkNumberPlayerSecondTeam()-> Int {
        
        var numberHeroesSecond: Int = 0// number of heroes in Second Team
        for element in 0..<teamFactory.arrayTeam.count { // counting number of heroes in First Team
            if teamFactory.arrayTeam[element].teamNameAlias == "second" { // counting number of heroes in Second Team
                numberHeroesSecond += 1
            }
        }
        return numberHeroesSecond
    }
}


