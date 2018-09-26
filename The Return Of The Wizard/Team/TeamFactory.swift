//
//  TeamFactory.swift
//  The Return Of The Wizard
//
//  Created by Patrick Wiley on 30/08/2018.
//  Copyright © 2018 Patrick Wiley. All rights reserved.
//

import Foundation


class TeamFactory {
    
    
    private let heroesFactory = HeroesFactory()
    let teamFirst = Team()
    let teamSecond = Team()
    
    //==============================
    // MARK: - METHODS  HEROES  =
    //==============================
    
    
    func getHeroeName() -> String { // create the heroeName
        
        var nameUnique: Bool = true
        var heroeName: String
        var choiceNameHeroe: String
        repeat {
            
            choiceNameHeroe = readLine()!
            nameUnique = checkNameHeroe(choiceNameHeroe : choiceNameHeroe.uppercased().trimmingCharacters(in: .whitespaces))
            
        }while nameUnique == false
        heroeName = choiceNameHeroe
        return heroeName.uppercased()
        
    }
    
    //==============================
    // MARK: - METHODS  TEAM  =
    //==============================
    
    func composeTeam(heroeName : String, heroesInt: String, teamType: TeamType) { // method createTeam
        
        let heroe = heroesFactory.getHeroe(heroesInt: heroesInt)!
        heroe.heroName = heroeName
        
        
        if teamType == .firstTeam {
            teamFirst.arrayTeam.append(heroe) // add heroes in array for first team
        }
        else {
            teamSecond.arrayTeam.append(heroe) // add heroes in array for second team
        }
        
    }
 
    //==============================
    // MARK: - METHODS EQUIPEMENT  =
    //==============================
   
    func NewEquipement(whoseTurn: Bool, heroeType: TypeHero, heroIndex: Int) { // method for randoming the new equipement
        
        var arrayTeam = [Heroes]()
        var equipementRoll: Int = 0
        var emojy: String = ""
        if whoseTurn == true {
            arrayTeam = teamFirst.arrayTeam
            emojy = "🤺"
        }
        else {
            arrayTeam = teamSecond.arrayTeam
            emojy = "🔱"
        }
        
        if heroeType == .Wizard {
            arrayTeam[heroIndex].equipment = Equipment.Scepter
        }
        else {
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
            
        
            
        default : print("You must choose a Weapon")
            
        }
        
    }
   
    func status(whoseTurn: Bool, noHeroes: Bool) -> [Heroes] {
    /*func status(whoseTurn: Bool, wizard: Bool) -> [Heroes] {  getting the status of the team by returning either the content of arrayTeam for team One
                                                                or the content of arrayTeam for team Two */
        
        var arrayStatusTeam = [Heroes]() // declaration and initialisation of the arrayStatusTeam(return by that method)
        var arrayTeam = [Heroes]() // declaration and initialisation of the arrayTeam which will be append to arrayStatusTeam
        if whoseTurn == true {
            arrayTeam = teamFirst.arrayTeam // arrayTeam set at teamFirst.arrayTeam
            
        }
        else {
            arrayTeam = teamSecond.arrayTeam // arrayTeam set at teamSecond.arrayTeam
            
        }
        if noHeroes == false {
            for element in 0..<arrayTeam.count { // Browse arrayTeamFirst(array of team One or team Two
                if arrayTeam[element].alive == true { // if there are alive only
                arrayStatusTeam.append(arrayTeam[element]) /* arrayStatusTeam will get the content of ArrayTeam either Team One
                                                                                                                    or TeamTwo */
                }
            }
        }
        else {
            for element in 0..<arrayTeam.count { // Browse arrayTeamFirst(array of team One or team Two
                if arrayTeam[element].alive == true { // if there are alive only
                    arrayStatusTeam.append(arrayTeam[element]) /* arrayStatusTeam will get the content of ArrayTeam either Team One
                     or TeamTwo */
                }
            }
        }
        return arrayStatusTeam // returning arrayStatusTeam by calling the method above
    }
   
    func fight(dispenser: Int, recipient: Int, whoseTurn: Bool, specialSpell: Bool) -> Int {
        
        var arrayDispenser = [Heroes]() // declaration of arrayDispenser contening data for team one
        var arrayRecipient = [Heroes]() // declaration of arrayDispenser contening data for team two
        var newLifeStrength: Int = 0 // declare the newLifeStrength property
        var newLifeStrengthWizard: Int = 0 // declare the newLifeStrengthWizard property
        
        arrayDispenser = status(whoseTurn: whoseTurn,noHeroes: false) // setting the arrayDispenser to arrayFirstTeam
        arrayRecipient = status(whoseTurn: !whoseTurn,noHeroes: false) // setting the arrayRecipient to arraySecondTeam

        
        
        if specialSpell == false { // if the spell of death was never uses and no asked the wizard is doing just a normal strike
            
            newLifeStrength = arrayRecipient[recipient].lifeStrength - (arrayDispenser[dispenser].shotStrength - arrayRecipient[recipient].armorStrength)
            arrayRecipient[recipient].lifeStrength = newLifeStrength // setting in the array of the attacked team the new point of life at the index of the attacked
            newLifeStrengthWizard = arrayDispenser[dispenser].lifeStrength - 10 // the wizard is having effect of the normal spell calling
            arrayDispenser[dispenser].lifeStrength = newLifeStrengthWizard // the wizard has new lifeStrenght
            if newLifeStrength <= 0 {
                arrayRecipient[recipient].alive = false // the hero is dead
            }
            if newLifeStrengthWizard < 0 {
                arrayDispenser[dispenser].alive = false // the wizard is dead
            }
        }
        else { // if the wizard do the special spell of death and it was never done before, the strike is a spell of death
            
            arrayRecipient[recipient].lifeStrength = 0 // setting in the array of the attacked hero in the team at 0 and alive property at not alive
            newLifeStrengthWizard = arrayDispenser[dispenser].lifeStrength - 30 // the wizard is having effect of the death spell calling
            arrayDispenser[dispenser].lifeStrength = newLifeStrengthWizard // the wizard has new lifeStrenght
            arrayRecipient[recipient].alive = false // the hero is dead
            if newLifeStrengthWizard < 0 {
                arrayDispenser[dispenser].alive = false // the wizard is dead
            }
        }
        return newLifeStrength
    }
    
    func heal(dispenser: Int,recipient: Int,whoseTurn: Bool) -> Int {
        
        var arrayDispenser = [Heroes]()
        var arrayRecipient = [Heroes]()
        //let recipient: Int = 0
        //let dispenser: Int = dispenser
        var newLifeStrength: Int
        
        arrayDispenser = status(whoseTurn: whoseTurn,noHeroes: false)
//        arrayDispenser = status(whoseTurn: whoseTurn, wizard: false)
        //print(arrayDispenser[dispenser])
        arrayRecipient = status(whoseTurn: whoseTurn,noHeroes: false)
//        arrayRecipient = status(whoseTurn: whoseTurn, wizard: false)
        //print(arrayRecipient[recipient])

        newLifeStrength = ((arrayRecipient[recipient].lifeStrength) + (arrayDispenser[dispenser].shotStrength))
        arrayRecipient[recipient].lifeStrength = newLifeStrength
        return newLifeStrength
    }
    
    
    func checkNameHeroe(choiceNameHeroe : String) -> Bool {
        
        for element in 0..<teamFirst.arrayTeam.count {
            if choiceNameHeroe == teamFirst.arrayTeam[element].heroName.uppercased() {
                print("There is already an Heroe with that name")
                print("Give another name to your Heroe")
                return false
            }
        }
        for element in 0..<teamSecond.arrayTeam.count {
            if choiceNameHeroe == teamSecond.arrayTeam[element].heroName.uppercased() {
                print("There is already an Heroe with that name")
                print("Give another name to your Heroe")
                return false
            }
        }
        
        return true
    }
    
//    func checkNoheroes() -> [Heroes] {
//        var array = [Heroes]()
//        for
//        return array
//    }
}
