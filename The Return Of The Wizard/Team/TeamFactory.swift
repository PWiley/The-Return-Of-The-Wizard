//
//  TeamFactory.swift
//  The Return Of The Wizard
//
//  Created by Patrick Wiley on 30/08/2018.
//  Copyright © 2018 Patrick Wiley. All rights reserved.
//

import Foundation


class TeamFactory {
    
    //let teamFactory = Team()
    let heroesFactory = HeroesFactory()
    let teamFirst = Team()
    let teamSecond = Team()
    
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
        //heroe.teamNameAlias = teamNameAlias
        
        if teamNameAlias == "First" {
            
            teamFirst.arrayTeam.append(heroe)
            //print("We have: \(teamFirst.arrayTeam.count) Heroes in the array of teams")
        }
        if teamNameAlias == "Second" {
            teamSecond.arrayTeam.append(heroe)
            //print("We have: \(teamSecond.arrayTeam.count) Heroes in the array of teams")
        }
        
        
    }
 
    //==============================
    // MARK: - METHODS EQUIPEMENT  =
    //==============================
    
    func NewEquipement(whoseTurn: Bool, heroeType: String, heroIndex: Int) { // method for randoming the new equipement
        
        var arrayTeam = [Heroes]()
        var equipementRoll: Int = 0
        var emojy: String = ""
        if whoseTurn == true {
        arrayTeam = teamFirst.arrayTeam
            emojy = "🤺"
        }
        if whoseTurn == false {
        arrayTeam = teamSecond.arrayTeam
            emojy = "🔱"
        }
        if heroeType == "Wizard" {
            arrayTeam[heroIndex].equipment = Equipment.Scepter
        }
        if heroeType != "Wizard" {
            equipementRoll = Int(arc4random_uniform(4) + 1)
        }
        
        let NewWeaponPlayer = equipementRoll
        switch NewWeaponPlayer {
        case 1 :
            
            arrayTeam[heroIndex].equipment = Equipment.Axe
            print(" \(emojy) Your new equipment is an Axe")
            
        case 2 :
            
            arrayTeam[heroIndex].equipment = Equipment.Hammer
            print(" \(emojy) Your new equipment is an Hammer")
            
        case 3 :
            
            arrayTeam[heroIndex].equipment = Equipment.Sword
            print(" \(emojy) Your new equipment is an Sword")
            
        
            
        default : print("YouYou must choose a Weapon")
            
        }
        
    }
   
    func statusFactoryTeam(whoseTurn: Bool,wizard: Bool) -> [Heroes] { /* getting the status of the team by returning either the content of arrayTeam for team One
         or the content of arrayTeam for team Two */
        //print("I am in statusFactoryTeam ")
        var arrayStatusTeam = [Heroes]() // declaration and initialisation of the arrayStatusTeam(return by that method)
        var arrayTeam = [Heroes]() // declaration and initialisation of the arrayTeam which will be append to arrayStatusTeam
        if whoseTurn == true {
            arrayTeam = teamFirst.arrayTeam // arrayTeam set at teamFirst.arrayTeam
        }
        if whoseTurn == false {
            arrayTeam = teamSecond.arrayTeam // arrayTeam set at teamSecond.arrayTeam
        }
        //        if whoseTurn == true { // if it is the turn for team One
        
        if wizard == false {
            for element in 0..<arrayTeam.count { // Browse arrayTeamFirst(array of team One or team Two
                if arrayTeam[element].alive == true { // if there are alive only
                arrayStatusTeam.append(arrayTeam[element]) /* arrayStatusTeam will get the content of ArrayTeam either Team One
                 or TeamTwo */
                }
            }
        }
        if wizard == true {
            for element in 0..<arrayTeam.count {
                if arrayTeam[element].type == "Wizard" && arrayTeam[element].alive == true { // if there is at least one wizard alive will return the list of the alived wizards
                    arrayStatusTeam.append(arrayTeam[element]) // arrayStatusTeam will get the content of ArrayTeam
                    //print(arrayStatusTeam)
                    
                }
            }
        }
        return arrayStatusTeam // returning arrayStatusTeam by calling the method above
    }
    // if whoseTurn == false { // if it is the turn for team Two
    
    //            if wizard == false {
    //                for element in 0..<teamSecond.arrayTeam.count { // Browse arrayTeamFirst(array of team One
    //
    //                    arrayStatusTeam.append(teamSecond.arrayTeam[element]) // arrayStatusTeam will get the content of ArrayTeamFirst
    //                }
    //            }
    //            if wizard == true {
    //                for element in 0..<teamSecond.arrayTeam.count {
    //                    if teamSecond.arrayTeam[element].type == "wizard" {
    //                        arrayStatusTeam.append(teamSecond.arrayTeam[element]) // arrayStatusTeam will get the content of ArrayTeamFirst
    //
    //                    }
    //                }
    //            }
    

        
       // return arrayStatusTeam // returning arrayStatusTeam by calling the method above

  
//    func teamHealing(dispenser: Int, recipient: Int, whoseTurn: Bool) -> Int{ // team is healing someone
//        var newLifeStrength: Int
//        if whoseTurn == true {
//            
//            newLifeStrength = ((teamFirst.arrayTeam[recipient].lifeStrength) + 5)
//            teamFirst.arrayTeam[recipient].lifeStrength = newLifeStrength
//            print(" 🤺 The hero you have just healed has now : \(teamFirst.arrayTeam[recipient].lifeStrength) points of life")
//            
//        }
//        if whoseTurn == false {
//            
//            newLifeStrength = ((teamSecond.arrayTeam[recipient].lifeStrength) + 5)
//            teamSecond.arrayTeam[recipient].lifeStrength = newLifeStrength
//            print(" 🔱 The hero you have just healed has now : \(teamSecond.arrayTeam[recipient].lifeStrength) points of life")
//        }
//        return newLifeStrength
//            }
    func fight(dispenser: Int, recipient: Int, whoseTurn: Bool, specialSpell: Bool) -> Int {
        
        var arrayDispenser = [Heroes]() // declaration of arrayDispenser contening data for team one
        var arrayRecipient = [Heroes]() // declaration of arrayDispenser contening data for team two
        var newLifeStrength: Int = 0 // declare the newLifeStrength property
        
        
        if whoseTurn == true {
      
            arrayDispenser = statusFactoryTeam(whoseTurn: true,wizard: false) // setting the arrayDispenser to arrayFirstTeam
            arrayRecipient = statusFactoryTeam(whoseTurn: false,wizard: false) // setting the arrayRecipient to arraySecondTeam
            
        }
        if whoseTurn == false {
            
            arrayDispenser = statusFactoryTeam(whoseTurn: false,wizard: false) // setting the arrayDispenser to arraySecondTeam
            arrayRecipient = statusFactoryTeam(whoseTurn: true,wizard: false) //setting the arrayRecipient to arrayFirstTeam
            
        }
        if specialSpell == false {
            
            newLifeStrength = arrayRecipient[recipient].lifeStrength - (arrayDispenser[dispenser].shotStrength-arrayRecipient[recipient].armorStrength)
            // lifeStrenght from attacked - ( shotstrenght of the attackers - armor shield of the attacked)
            arrayRecipient[recipient].lifeStrength = newLifeStrength // setting in the array of the attacked team the new point of life at the index of the attacked
            
            if newLifeStrength < 0 {
                arrayRecipient[recipient].alive = false // the hero is dead
            }
        }
        
        if specialSpell == true {
            
            newLifeStrength = 0 // te wizard use his Spell of death
            arrayRecipient[recipient].lifeStrength = 0 // setting in the array of the attacked hero in the team at 0 and alive property at not alive
            arrayRecipient[recipient].alive = false // the hero is dead
        }
        return newLifeStrength
    }
    func heal(dispenser: Int,recipient: Int,whoseTurn: Bool) -> Int {
        
        var arrayDispenser = [Heroes]()
        var arrayRecipient = [Heroes]()
        let recipient: Int = 0
        let dispenser: Int = 0
        var newLifeStrength: Int
        
        
        if game.whoseTurn == true {
            
            arrayDispenser = statusFactoryTeam(whoseTurn: true, wizard: true)
            arrayRecipient = statusFactoryTeam(whoseTurn: true, wizard: false)
            
            
        }
        if game.whoseTurn == false {
            
            arrayDispenser = statusFactoryTeam(whoseTurn: false, wizard: true)
            arrayRecipient = statusFactoryTeam(whoseTurn: false, wizard: false)
           
        }
        newLifeStrength = ((arrayRecipient[recipient].lifeStrength) + (arrayDispenser[dispenser].shotStrength))
        arrayRecipient[recipient].lifeStrength = newLifeStrength
        return newLifeStrength
    }
    
    
    func checkNameHeroe(choiceNameHeroe : String) -> Bool {
        var unique: Bool = true
        let heroeNameEnter = choiceNameHeroe
        
        
        for element in 0..<teamFirst.arrayTeam.count {
            if heroeNameEnter == teamFirst.arrayTeam[element].heroName {
                print("There is already an Heroe with that name")
                print("Give another name to your Heroe")
                unique = false
            }
        }
        for element in 0..<teamSecond.arrayTeam.count {
            if heroeNameEnter == teamSecond.arrayTeam[element].heroName {
                print("There is already an Heroe with that name")
                print("Give another name to your Heroe")
                unique = false
            }
        }
        
        return unique
    }
    

    
//    func getDispensersTeamWithoutWizardSelected(whoseTurn: Bool) -> Bool{ // getDispensersTeam
//        
//        var wizardExist: Bool = true // boolean set at true managing if there is a wizard in the team
//        
//        if whoseTurn == true { // will give to the player First in roll his possible Heroes
//            
//            for element in 0..<teamFirst.arrayTeam.count {
//                if teamFirst.arrayTeam[element].type == "Wizard" {
//                    wizardExist = true
//                }
//                else {
//                    wizardExist = false
//                }
//            }
//            
//        }
//        if whoseTurn == false { // will give to the player First in roll his possible Heroes
//            for element in 0..<teamSecond.arrayTeam.count {
//                if teamSecond.arrayTeam[element].type == "Wizard" {
//                    wizardExist = true
//                }
//                else {
//                    wizardExist = false
//                }
//            }
//            
//        }
//        return wizardExist
//    }

    
    
}
