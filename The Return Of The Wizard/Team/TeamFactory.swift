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
    func statusTeam() -> ([Heroes],[Heroes]) {
        
        //let teamAlias = statusChoice
        //print("that is the content of teamFactory.arrayTeam \(teamFactory.arrayTeam)")
        //let chosenTeamStatus: String = statusChoice
        var arrayStatusTeamFirst = [Heroes]()
        var arrayStatusTeamSecond = [Heroes]()
        
        //        if chosenTeamStatus == "First" {
        for element in 0..<teamFactory.arrayTeamFirst.count {
            
            //print("We have the player of type\(teamFactory.arrayTeamFirst[element].heroeName) in Team  \(teamFactory.arrayTeamFirst[element].teamNameAlias)")
            arrayStatusTeamFirst.append(teamFactory.arrayTeamFirst[element])
            
        }
        //}
        //if chosenTeamStatus == "Second" {
        for element in 0..<teamFactory.arrayTeamSecond.count {
            
            //print("We have the player of type\(teamFactory.arrayTeamSecond[element].heroeName) in Team  \(teamFactory.arrayTeamSecond[element].teamNameAlias)")
            arrayStatusTeamSecond.append(teamFactory.arrayTeamFirst[element])
            
        }
        game.actionMenu(arrayStatusTeamFirst: arrayStatusTeamFirst, arrayStatusTeamSecond: arrayStatusTeamSecond)
        return (arrayStatusTeamFirst, arrayStatusTeamSecond)
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
    
    
    // fight(dispenser: dispenserRow, recipent: recipientRow) to call
    // fight(dispenser: Int, recipent: Int)
    func fight(dispenser: Int, recipient: Int, dispenserTeam: String) {
        
        
        
        // lifeStrength(recipient) = lifestrenght(recipient) - (shotStrength(dispenser) - (armorStrength(recipient)/2)
        if dispenserTeam == "First" {
            let newLifeStrength: Int = teamFactory.arrayTeamSecond[recipient].lifeStrength - (teamFactory.arrayTeamFirst[dispenser].shotStrength-(teamFactory.arrayTeamSecond[recipient].armorStrength / 2))
            teamFactory.arrayTeamSecond[recipient].lifeStrength = newLifeStrength
        }
        
        if dispenserTeam == "Second" {
            let newLifeStrength: Int = teamFactory.arrayTeamFirst[recipient].lifeStrength - (teamFactory.arrayTeamSecond[dispenser].shotStrength-(teamFactory.arrayTeamFirst[recipient].armorStrength / 2))
            teamFactory.arrayTeamFirst[recipient].lifeStrength = newLifeStrength
        }
        
        
    }
    //func heal(dispenser: dispenserRow, recipient: recipientRow, dispenserTeam: "First")
    
    func heal(dispenser: Int, recipient: Int, dispenserTeam: String) {
        
        // lifeStrength(recipient) = lifestrenght(recipient) + (shotStrength(dispenser) / 4
        
        if dispenserTeam == "First" {
            let newLifeStrength: Int = teamFactory.arrayTeamFirst[recipient].lifeStrength + (teamFactory.arrayTeamFirst[dispenser].shotStrength / 4 )
            teamFactory.arrayTeamFirst[recipient].lifeStrength = newLifeStrength
        }
        
        if dispenserTeam == "Second" {
            let newLifeStrength: Int = teamFactory.arrayTeamSecond[recipient].lifeStrength + (teamFactory.arrayTeamSecond[dispenser].shotStrength / 4 )
            teamFactory.arrayTeamSecond[recipient].lifeStrength = newLifeStrength
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
    
    // getDispensersTeam(playerTurn: "First", heroeRow: element)
    
    func getDispensersTeam(playerTurn: String,heroeRow: Int) { // getDispensersTeam
        
        // giving the attackers in the team in  action
        //var arrayAttackers = [Heroes]()

        if playerTurn == "First" { // will give to the player First in roll his possible Heroes
            print(teamFactory.arrayTeamFirst[heroeRow].type)
            
        }
        if playerTurn == "Second"{ // will give to the player Second in roll his possible Heroes
            
           print(teamFactory.arrayTeamSecond[heroeRow].type)
            
        }



    }
    func getRecipientsTeam(playerTurn: String,heroeRow: Int) {  //  getRecipientsTeam
        // giving the defendants in the adverse team
//        var arrayDefendants = [Heroes]()
        
        if playerTurn == "First" { // will give to the player First in roll his possible Heroes
            
            print(teamFactory.arrayTeamFirst[heroeRow].type)
            
        }
        
        if playerTurn == "Second"{ // will give to the player Second in roll his possible Heroes
            
            print(teamFactory.arrayTeamSecond[heroeRow].type)
            
        }
        
    }
    func getDispensersTeamWithoutWizardSelected(element: Int, playerTurn: String) -> [Heroes]{ // getDispensersTeam
        
        
        
        if playerTurn == "First" { // will give to the player First in roll his possible Heroes
            teamFactory.arrayWithoutWizard.append(teamFactory.arrayTeamFirst[element])
        }
        
    
        if playerTurn == "Second" { // will give to the player Second in roll his possible Heroes
            
            teamFactory.arrayWithoutWizard.append(teamFactory.arrayTeamSecond[element])
            
        }
        return teamFactory.arrayWithoutWizard
}

}
