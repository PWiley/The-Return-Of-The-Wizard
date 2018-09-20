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
    
    //==============================
    // MARK: - METHODS  HEROES  =
    //==============================
    
    
    func getHeroeName() -> String{ // create the heroeName
        
        var nameUnique: Bool = true
        var heroeName: String
        var choiceNameHeroe: String
        repeat {
            
            choiceNameHeroe = readLine()!
            nameUnique = checkNameHeroe(choiceNameHeroe : choiceNameHeroe.uppercased())
            
            
        }while nameUnique == false
        heroeName = choiceNameHeroe.uppercased()
        return heroeName
        
    }
    
    //==============================
    // MARK: - METHODS  TEAM  =
    //==============================
    
    func composeTeam(heroeName : String, heroesInt: String, teamNameAlias: String) { // method createTeam
        
        let choicePlayer = heroesInt
        let heroe = heroesFactory.getHeroe(heroesInt: choicePlayer)!
        heroe.heroName = heroeName
        heroe.teamNameAlias = teamNameAlias
        
        if teamNameAlias == "First" {
            
            teamFactory.arrayTeamFirst.append(heroe)
            //print("We have: \(teamFactory.arrayTeamFirst.count) Heroes in the array of teams")
        }
        if teamNameAlias == "Second" {
            teamFactory.arrayTeamSecond.append(heroe)
            //print("We have: \(teamFactory.arrayTeamSecond.count) Heroes in the array of teams")
        }
        
        
    }
 
    //==============================
    // MARK: - METHODS EQUIPEMENT  =
    //==============================
    
    func NewEquipement(heroeName : String, heroesInt: String, weaponChoice: String) { // method for giving the choice for a new weapon // First not possible
        
        let choicePlayer = heroesInt
        let name = heroeName
        
        let choiceWeaponPlayer = weaponChoice
        switch choiceWeaponPlayer {
        case "1" :
            
            let equipment = Equipment.Axe
            let equipmentEffect = equipment.rawValue // Printing the value of Axe
            print("The effect of your equipment is \(equipmentEffect)")
            
            let heroe = heroesFactory.getHeroe(heroesInt: choicePlayer)!
            heroe.heroName = name
            heroe.equipment = equipment
            
            
        case "2" :
            
            let equipment = Equipment.Hammer
            let equipmentEffect = equipment.rawValue // Printing the value of Hammer
            print("The effect of your equipment is \(equipmentEffect)")
            
            let heroe = heroesFactory.getHeroe(heroesInt: choicePlayer)!
            heroe.heroName = name
            heroe.equipment = equipment
            
        case "3" :
            
            let equipment = Equipment.Sword
            let equipmentEffect = equipment.rawValue // Printing the value of Sword
            print("The effect of your equipment is \(equipmentEffect)")
            
            let heroe = heroesFactory.getHeroe(heroesInt: choicePlayer)!
            heroe.heroName = name
            heroe.equipment = equipment
            
        case "4" :
            
            let equipment = Equipment.Scepter
            let equipmentEffect = equipment.rawValue // Printing the value of Scepter
            print("The effect of your equipment is \(equipmentEffect)")
            
            let heroe = heroesFactory.getHeroe(heroesInt: choicePlayer)!
            heroe.heroName = name
            heroe.equipment = equipment
            
        case "5" :
            
            let heroe = heroesFactory.getHeroe(heroesInt: choicePlayer)!
            heroe.heroName = name
            
        default : print("You must choose a Weapon")
            
        }
        
        
        
        
    }
   
    func statusFactoryTeam(whoseTurn: Bool,wizard: Bool) -> [Heroes] { /* getting the status of the team by returning either the content of arrayTeam for team One
         or the content of arrayTeam for team Two */
        
        var arrayStatusTeam = [Heroes]() // declaration and initialisation of the arrayStatusTeam(return by that method)
        var arrayTeam = [Heroes]() // declaration and initialisation of the arrayTeam which will be append to arrayStatusTeam
        if whoseTurn == true {
            arrayTeam = teamFactory.arrayTeamFirst // arrayTeam set at teamFactory.arrayTeamFirst
        }
        if whoseTurn == false {
            arrayTeam = teamFactory.arrayTeamSecond // arrayTeam set at teamFactory.arrayTeamSecond
        }
        //        if whoseTurn == true { // if it is the turn for team One
        
        if wizard == false {
            for element in 0..<arrayTeam.count { // Browse arrayTeamFirst(array of team One
                
                arrayStatusTeam.append(arrayTeam[element]) /* arrayStatusTeam will get the content of ArrayTeam either Team One
                 or TeamTwo */
            }
        }
        if wizard == true {
            for element in 0..<arrayTeam.count {
                if arrayTeam[element].type == "wizard" {
                    arrayStatusTeam.append(arrayTeam[element]) // arrayStatusTeam will get the content of ArrayTeam
                    
                }
            }
        }
        return arrayStatusTeam // returning arrayStatusTeam by calling the method above
    }
    // if whoseTurn == false { // if it is the turn for team Two
    
    //            if wizard == false {
    //                for element in 0..<teamFactory.arrayTeamSecond.count { // Browse arrayTeamFirst(array of team One
    //
    //                    arrayStatusTeam.append(teamFactory.arrayTeamSecond[element]) // arrayStatusTeam will get the content of ArrayTeamFirst
    //                }
    //            }
    //            if wizard == true {
    //                for element in 0..<teamFactory.arrayTeamSecond.count {
    //                    if teamFactory.arrayTeamSecond[element].type == "wizard" {
    //                        arrayStatusTeam.append(teamFactory.arrayTeamSecond[element]) // arrayStatusTeam will get the content of ArrayTeamFirst
    //
    //                    }
    //                }
    //            }
    

        
       // return arrayStatusTeam // returning arrayStatusTeam by calling the method above

  
//    func teamHealing(dispenser: Int, recipient: Int, whoseTurn: Bool) -> Int{ // team is healing someone
//        var newLifeStrength: Int
//        if whoseTurn == true {
//            
//            newLifeStrength = ((teamFactory.arrayTeamFirst[recipient].lifeStrength) + 5)
//            teamFactory.arrayTeamFirst[recipient].lifeStrength = newLifeStrength
//            print(" 🤺 The hero you have just healed has now : \(teamFactory.arrayTeamFirst[recipient].lifeStrength) points of life")
//            
//        }
//        if whoseTurn == false {
//            
//            newLifeStrength = ((teamFactory.arrayTeamSecond[recipient].lifeStrength) + 5)
//            teamFactory.arrayTeamSecond[recipient].lifeStrength = newLifeStrength
//            print(" 🔱 The hero you have just healed has now : \(teamFactory.arrayTeamSecond[recipient].lifeStrength) points of life")
//        }
//        return newLifeStrength
//            }
    func fight(dispenser: Int, recipient: Int, whoseTurn: Bool) -> Int {
        
        var arrayDispenser = [Heroes]()
        var arrayRecipient = [Heroes]()
        
        
        if whoseTurn == true {
      
            arrayDispenser = statusFactoryTeam(whoseTurn: true,wizard: false) // setting the arrayDispenser to arrayFirstTeam
            arrayRecipient = statusFactoryTeam(whoseTurn: false,wizard: false) // setting the arrayRecipient to arraySecondTeam
            
        }
        if whoseTurn == false {
            
            arrayDispenser = statusFactoryTeam(whoseTurn: false,wizard: false) // setting the arrayDispenser to arraySecondTeam
            arrayRecipient = statusFactoryTeam(whoseTurn: true,wizard: false) //setting the arrayRecipient to arrayFirstTeam
            
        }
        
        let newLifeStrength: Int = arrayRecipient[recipient].lifeStrength - (arrayDispenser[dispenser].shotStrength-arrayRecipient[recipient].armorStrength)
            // lifeStrenght from attacked - ( shotstrenght of the attackers - armor shield of the attacked)
        arrayRecipient[recipient].lifeStrength = newLifeStrength // setting in the array of the attacked team the new point of life at the index of the attacked
        return newLifeStrength
    }
    func heal(dispenser: Int,recipient: Int,whoseTurn: Bool) -> Int {
        
        var arrayDispenser = [Heroes]()
        let recipient: Int = 0
        let dispenser: Int = 0
        var newLifeStrength: Int
        
        
        if game.whoseTurn == true {
            arrayDispenser = statusFactoryTeam(whoseTurn: true, wizard: false)
        }
        if game.whoseTurn == false {
            
            arrayDispenser = statusFactoryTeam(whoseTurn: false, wizard: false)
            
            
        }
        newLifeStrength = ((arrayDispenser[recipient].lifeStrength) + (arrayDispenser[dispenser].shotStrength))
        arrayDispenser[recipient].lifeStrength = newLifeStrength
        return newLifeStrength
    }
    
    
    func checkNameHeroe(choiceNameHeroe : String) -> Bool {
        var unique: Bool = true
        let heroeNameEnter = choiceNameHeroe
        
        
        for element in 0..<teamFactory.arrayTeamFirst.count {
            if heroeNameEnter == teamFactory.arrayTeamFirst[element].heroName {
                print("There is already an Heroe with that name")
                print("Give another name to your Heroe")
                unique = false
            }
        }
        for element in 0..<teamFactory.arrayTeamSecond.count {
            if heroeNameEnter == teamFactory.arrayTeamSecond[element].heroName {
                print("There is already an Heroe with that name")
                print("Give another name to your Heroe")
                unique = false
            }
        }
        
        return unique
    }
    

    
    func getDispensersTeamWithoutWizardSelected(whoseTurn: Bool) -> Bool{ // getDispensersTeam
        
        var wizardExist: Bool = false // boolean set at true managing if there is a wizard in the team
        
        if whoseTurn == true { // will give to the player First in roll his possible Heroes
            
            for element in 0..<teamFactory.arrayTeamFirst.count {
                if teamFactory.arrayTeamFirst[element].type == "Wizard" {
                    wizardExist = true
                }
                else {
                    wizardExist = false
                }
            }
            
        }
        if whoseTurn == false { // will give to the player First in roll his possible Heroes
            for element in 0..<teamFactory.arrayTeamSecond.count {
                if teamFactory.arrayTeamSecond[element].type == "Wizard" {
                    wizardExist = true
                }
                else {
                    wizardExist = false
                }
            }
            
        }
        return wizardExist
    }

    
    
}
