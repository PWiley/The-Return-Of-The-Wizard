//
//  TeamFactory.swift
//  The Return Of The Wizard
//
//  Created by Patrick Wiley on 30/08/2018.
//  Copyright © 2018 Patrick Wiley. All rights reserved.
//

import Foundation

/***
 This class will manage all the settings concerning the two different teams
 ***/
class TeamFactory {
    
    
    private let heroesFactory = HeroesFactory() // creates an instance of HeroesFactory
    let teamFirst = Team() // creates an instance for team First
    let teamSecond = Team() // creates an instance for team Second
    
    //==============================
    // MARK: - METHODS  HEROES  =
    //==============================
    
    
    func getHeroName() -> String { // creates the heroeName
        
        var nameUnique: Bool = true // boolean allows to know if the uniqueness of the heros name is respected
        var heroName: String // will take th value of the accepted name
        var choiceNameHeroe: String // answer from the player
        repeat {
            
            choiceNameHeroe = readLine()!
            nameUnique = checkNameHeroe(choiceNameHeroe :  choiceNameHeroe.uppercased().trimmingCharacters(in: .whitespaces)) // check the uniqueness of the name //
            
        }while nameUnique == false
        heroName = choiceNameHeroe // if name unique then we set the accepted name to heroName
        return heroName.uppercased()
        
    }
    
    //==============================
    // MARK: - METHODS  TEAM  =
    //==============================
    
    /*** Method creates the team one or two by adding the hero after check to either array for teamFirst
     or array for teamSecond ***/
    func composeTeam(heroeName : String, heroesInt: String, teamType: TeamType) { // method createTeam
        
        let hero = heroesFactory.getHeroe(heroesInt: heroesInt)! // get the type of hero and set its name with the name chose by the player
        hero.heroName = heroeName
        
        
        if teamType == .firstTeam {
            teamFirst.arrayTeam.append(hero) // add heroes in array for first team
        }
        else {
            teamSecond.arrayTeam.append(hero) // add heroes in array for second team
        }
        
    }
    
    //==============================
    // MARK: - METHODS EQUIPEMENT  =
    //==============================
    
    
    
    /*** Getting the status of the team by returning either the content of arrayTeam for team One
     or the content of arrayTeam for team Two ***/
    func status(whoseTurn: Bool, noHeroes: Bool) -> [Heroes] {
        
        
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
    /***
     Method calculates the new lifStrenght in case of fight ***/
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
            if (arrayDispenser[dispenser]).type == TypeHero.Wizard {
                newLifeStrengthWizard = arrayDispenser[dispenser].lifeStrength - 10 // the wizard is having effect of the normal spell calling
                arrayDispenser[dispenser].lifeStrength = newLifeStrengthWizard // the wizard has new lifeStrenght
            }
            if newLifeStrength <= 0 {
                arrayRecipient[recipient].alive = false // the hero is dead
            }
            if newLifeStrengthWizard < 0 {
                arrayDispenser[dispenser].alive = false // the wizard is dead
            }
        }
        else { // if the wizard do the special spell of death and it was never done before, the strike is a spell of death
            
            arrayRecipient[recipient].lifeStrength = 0 // setting in the array of the attacked hero in the team at 0 and alive property at not alive
            newLifeStrengthWizard = arrayDispenser[dispenser].lifeStrength - 40 // the wizard is having effect of the death spell calling
            arrayDispenser[dispenser].lifeStrength = newLifeStrengthWizard // the wizard has new lifeStrenght
            arrayRecipient[recipient].alive = false // the hero is dead
            if newLifeStrengthWizard < 0 {
                arrayDispenser[dispenser].alive = false // the wizard is dead
            }
        }
        return newLifeStrength // new life Strenght
    }
    /***method which calculate the new life Strenght  of the hero ***/
    func heal(dispenser: Int,recipient: Int,whoseTurn: Bool) -> Int {
        
        var arrayDispenser = [Heroes]() // declaration of arrayDispenser contening data for team one
        var arrayRecipient = [Heroes]() // declaration of arrayDispenser contening data for team two
        
        var newLifeStrength: Int
        
        arrayDispenser = status(whoseTurn: whoseTurn,noHeroes: false) // setting the arrayDispenser to arrayFirstTeam
        
        arrayRecipient = status(whoseTurn: whoseTurn,noHeroes: false) // setting the arrayDispenser to arraySecondTeam
        
        
        newLifeStrength = ((arrayRecipient[recipient].lifeStrength) + /*** calculate the new points of life ***/ (arrayDispenser[dispenser].shotStrength))
        arrayRecipient[recipient].lifeStrength = newLifeStrength
        return newLifeStrength
    }
    
    /*** Checks the uniqueness of the given name by the player  ***/
    func checkNameHeroe(choiceNameHeroe : String) -> Bool {
        
        for element in 0..<teamFirst.arrayTeam.count { // browse array Team First
            if choiceNameHeroe == teamFirst.arrayTeam[element].heroName.uppercased() {
                print("There is already an Heroe with that name")
                print("Give another name to your Heroe")
                return false
            }
        }
        for element in 0..<teamSecond.arrayTeam.count { // browse array Team Second
            if choiceNameHeroe == teamSecond.arrayTeam[element].heroName.uppercased() {
                print("There is already an Heroe with that name")
                print("Give another name to your Heroe")
                return false
            }
        }
        
        return true
    }
    
}
