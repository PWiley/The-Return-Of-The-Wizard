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
        
        
        if teamNameAlias == "First" {
            
            let choicePlayer = heroesInt
            let heroe = heroesFactory.getHeroe(heroesInt: choicePlayer)!
            heroe.heroeName = heroeName
            heroe.teamNameAlias = teamNameAlias
            teamFactory.arrayTeamFirst.append(heroe)
            //print("We have: \(teamFactory.arrayTeam.count) Heroes in the array of teams")
            print(teamFactory.arrayTeamFirst)
            print(heroe.teamNameAlias)
        }
        if teamNameAlias == "Second" {
            
            let choicePlayer = heroesInt
            let heroe = heroesFactory.getHeroe(heroesInt: choicePlayer)!
            heroe.heroeName = heroeName
            heroe.teamNameAlias = teamNameAlias
            teamFactory.arrayTeamSecond.append(heroe)
            //print("We have: \(teamFactory.arrayTeam.count) Heroes in the array of teams")
            print(teamFactory.arrayTeamSecond)
            print(heroe.teamNameAlias)
        }

        
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
        
        //let teamAlias = statusChoice
        //print("that is the content of teamFactory.arrayTeam \(teamFactory.arrayTeam)")
        let chosenTeamStatus: String = statusChoice
        
        if chosenTeamStatus == "First" {
        for element in 0..<teamFactory.arrayTeamFirst.count {
            
            print("We have the player of type\(teamFactory.arrayTeamFirst[element].heroeName) in Team  \(teamFactory.arrayTeamFirst[element].teamNameAlias)")
                
            }
        }
        if chosenTeamStatus == "Second" {
        for element in 0..<teamFactory.arrayTeamSecond.count {
        
            print("We have the player of type\(teamFactory.arrayTeamSecond[element].heroeName) in Team  \(teamFactory.arrayTeamSecond[element].teamNameAlias)")
            
        }
        }
        game.mainMenu()
    }
    func heal(whoseTurn: String) {
        
        if teamFactory.arrayTeamFirst.isEmpty && teamFactory.arrayTeamSecond.isEmpty { // testing if the teams are created
            print("You must create two teams")
            game.createTeamMenu()
        }
        if whoseTurn == "First" { // testing if there is a wizard in team First
            print("It is the time for team \(whoseTurn) to heal someone")
            for element in 0..<teamFactory.arrayTeamFirst.count {
                if teamFactory.arrayTeamFirst[element].type == "wizard" {
                    print("Who do you want to heal?")
                }
            }
        }
        
        if whoseTurn == "Second" { // testing if there is a wizard in team First
            print("It is the time for team \(whoseTurn) to heal someone")
            for element in 0..<teamFactory.arrayTeamSecond.count {
                if teamFactory.arrayTeamSecond[element].type == "wizard" {
                    print("Who do you want to heal?")
                }
            }
        }
       
    }
    func fight(whoseTurn: String) {
        let whoseTurn: String = whoseTurn
        if teamFactory.arrayTeamFirst.isEmpty && teamFactory.arrayTeamSecond.isEmpty { // testing if the teams are created
            print("You must create two teams")
            game.createTeamMenu()
        }
        else {
            print("You would like to fight against someone")
            
            if whoseTurn == "First" {
                print("It is the time for team \(whoseTurn) to fight")
                print("againt who do you want to fight?")
            }
            
            if whoseTurn == "Second" {
                print("It is the time for team \(whoseTurn) to fight")
                print("againt who do you want to fight?")
            }
            
        }
    }
    func checkUniqueNameHeroe(heroeNameGiven : String) -> Bool {
        var unique: Bool = true
        let heroeNameEnter = heroeNameGiven
        
        for element in 0..<teamFactory.arrayTeamFirst.count {
            if heroeNameEnter == teamFactory.arrayTeamFirst[element].heroeName {
                print("There is already an Heroe with that name")
                print("Give another name to your Heroe")
                unique = false
            }
        }
        for element in 0..<teamFactory.arrayTeamSecond.count {
            if heroeNameEnter == teamFactory.arrayTeamSecond[element].heroeName {
                print("There is already an Heroe with that name")
                print("Give another name to your Heroe")
                unique = false
            }
        }
        
        return unique
    }
    func checkNumberPlayerFirstTeam()-> Int {
        var numberHeroesFirst: Int = 0 // number of heroes in First Team
        
        for _ in 0..<teamFactory.arrayTeamFirst.count { // counting number of heroes in First Team
//            if teamFactory.arrayTeamFirst[element].teamNameAlias == "first" { // counting number of heroes in First Team
//                numberHeroesFirst += 1
//            }
            numberHeroesFirst += 1
        }
        return numberHeroesFirst
    }
    func checkNumberPlayerSecondTeam()-> Int {
        
        var numberHeroesSecond: Int = 0// number of heroes in Second Team
        for _ in 0..<teamFactory.arrayTeamSecond.count { // counting number of heroes in First Team
//            if teamFactory.arrayTeamSecond[element].teamNameAlias == "second" { // counting number of heroes in Second Team
//                numberHeroesSecond += 1
//            }
            numberHeroesSecond += 1
        }
        return numberHeroesSecond
    }
}


