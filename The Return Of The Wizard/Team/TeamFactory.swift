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
        var heroeName: String
        var choiceNameHeroe: String
        repeat {
            
            choiceNameHeroe = readLine()!
            nameUnique = checkNameHeroe(choiceNameHeroe : choiceNameHeroe.uppercased())
            
            
        }while nameUnique == false
        heroeName = choiceNameHeroe.uppercased()
        return heroeName
        
    }
    
    
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
   
    func statusFactoryTeam(whoseTurn: Bool) -> [Heroes] {
        
        var arrayStatusTeam = [Heroes]()
        
        if whoseTurn == true {
            for element in 0..<teamFactory.arrayTeamFirst.count {
                
                arrayStatusTeam.append(teamFactory.arrayTeamFirst[element])
                
            }
        }
        if whoseTurn == false {
            for element in 0..<teamFactory.arrayTeamSecond.count {
                
                
                arrayStatusTeam.append(teamFactory.arrayTeamSecond[element])
                
            }
        }
        
        return arrayStatusTeam
    }
    
    //    func heal(whoseTurn: String) {
    //
    //        if teamFactory.arrayTeamFirst.isEmpty && teamFactory.arrayTeamSecond.isEmpty { // testing if the teams are created
    //            print("You must create two teams")
    //            game.createTeamMenu()
    //        }
    ////        if whoseTurn == "First" { // testing if there is a wizard in team First
    ////            print("It is the time for team \(whoseTurn) to heal someone")
    ////            for element in 0..<teamFactory.arrayTeamFirst.count {
    ////                if teamFactory.arrayTeamFirst[element].type == "wizard" {
    ////                    print("Who do you want to heal?")
    ////                }
    ////            }
    ////        }
    //
    //        if whoseTurn == "Second" { // testing if there is a wizard in team First
    //            print("It is the time for team \(whoseTurn) to heal someone")
    //            for element in 0..<teamFactory.arrayTeamSecond.count {
    //                if teamFactory.arrayTeamSecond[element].type == "wizard" {
    //                    print("Who do you want to heal?")
    //                }
    //            }
    //        }
    //
    //    }
    
    
    // fight(dispenser: dispenserRow, recipent: recipientRow) to call
    // fight(dispenser: Int, recipent: Int)
    //    func fight(dispenser: Int, recipient: Int, dispenserTeam: String) {
    //        
    //        
    //        
    //        // lifeStrength(recipient) = lifestrenght(recipient) - (shotStrength(dispenser) - (armorStrength(recipient)/2)
    //        if dispenserTeam == "First" {
    //            let newLifeStrength: Int = teamFactory.arrayTeamSecond[recipient].lifeStrength - (teamFactory.arrayTeamFirst[dispenser].shotStrength-(teamFactory.arrayTeamSecond[recipient].armorStrength / 2))
    //            teamFactory.arrayTeamSecond[recipient].lifeStrength = newLifeStrength
    //        }
    //        
    //        if dispenserTeam == "Second" {
    //            let newLifeStrength: Int = teamFactory.arrayTeamFirst[recipient].lifeStrength - (teamFactory.arrayTeamSecond[dispenser].shotStrength-(teamFactory.arrayTeamFirst[recipient].armorStrength / 2))
    //            teamFactory.arrayTeamFirst[recipient].lifeStrength = newLifeStrength
    //        }
    //        
    //        
    //    }
    //func heal(dispenser: dispenserRow, recipient: recipientRow, dispenserTeam: "First")
    
    //    func heal(dispenser: Int, recipient: Int, dispenserTeam: String) {
    //
    //        // lifeStrength(recipient) = lifestrenght(recipient) + (shotStrength(dispenser) / 4
    //
    //        if dispenserTeam == "First" {
    //            let newLifeStrength: Int = teamFactory.arrayTeamFirst[recipient].lifeStrength + (teamFactory.arrayTeamFirst[dispenser].shotStrength / 4 )
    //            teamFactory.arrayTeamFirst[recipient].lifeStrength = newLifeStrength
    //        }
    //
    //        if dispenserTeam == "Second" {
    //            let newLifeStrength: Int = teamFactory.arrayTeamSecond[recipient].lifeStrength + (teamFactory.arrayTeamSecond[dispenser].shotStrength / 4 )
    //            teamFactory.arrayTeamSecond[recipient].lifeStrength = newLifeStrength
    //        }
    //
    //
    //    }
    
    //    func teamFirstAction(){
    //        
    //        print("Team One you have the hand")
    //        print("What do you want to do?")
    //        if let choicePlayer = readLine() {
    //            if choicePlayer == "1" {
    //                
    //                teamFirstAttacking(dispenser: Int, recipient: Int) // team One is attacking
    //            }
    //            if choicePlayer == "2" {
    //                
    //                teamFirstHealing(dispenser: Int, recipient: Int) // team One is healing someone of his team
    //            }
    //        }
    //        
    //        
    //        game.whoseTurn.toggle() // passing the hand to team Second
    //        print(game.whoseTurn)
    //    }
    //    func teamSecondAction(dispenser: Int, recipient: Int){
    //        
    //        print("Team Two you have the hand")
    //        print("What do you want to do?")
    //        if let choicePlayer = readLine() {
    //            if choicePlayer == "1" {
    //                
    //                teamSecondAttacking(dispenser: Int, recipient: Int) // team One is attacking
    //            }
    //            if choicePlayer == "2" {
    //                
    //                teamSecondHealing(dispenser: Int, recipient: Int) // team One is healing someone of his team
    //            }
    //        }
    //        
    //        game.whoseTurn.toggle() // passing the hand to team First
    //        print(game.whoseTurn)
    //    }
    func teamAttacking(dispenser: Int, recipient: Int, whoseTurn: Bool) { // team is attacking
        if whoseTurn == true {
            
            print("Points de vie de l'attaqué : \(teamFactory.arrayTeamSecond[recipient].lifeStrength)")
            print("Points de coup porté : \(teamFactory.arrayTeamFirst[dispenser].shotStrength)")
            print("Protection du bouclier de l'attaqué : \(teamFactory.arrayTeamSecond[recipient].armorStrength)")
            
            let newLifeStrength: Int = teamFactory.arrayTeamSecond[recipient].lifeStrength - (teamFactory.arrayTeamFirst[dispenser].shotStrength-teamFactory.arrayTeamSecond[recipient].armorStrength)
            teamFactory.arrayTeamSecond[recipient].lifeStrength = newLifeStrength
            print("le hero que vous venez dàttaquer a à présent : \(teamFactory.arrayTeamSecond[recipient].lifeStrength)")
            
        }
        if whoseTurn == false {
            print("Points de vie de l'attaqué : \(teamFactory.arrayTeamFirst[recipient].lifeStrength)")
            print("Points de coup porté : \(teamFactory.arrayTeamSecond[dispenser].shotStrength)")
            print("Protection du bouclier de l'attaqué : \(teamFactory.arrayTeamFirst[recipient].armorStrength)")
            
            let newLifeStrength: Int = teamFactory.arrayTeamFirst[recipient].lifeStrength - (teamFactory.arrayTeamSecond[dispenser].shotStrength-teamFactory.arrayTeamFirst[recipient].armorStrength)
            teamFactory.arrayTeamFirst[recipient].lifeStrength = newLifeStrength
            print("le hero que vous venez dàttaquer a à présent : \(teamFactory.arrayTeamFirst[recipient].lifeStrength)")
            
        }
    }
    
    func teamHealing(dispenser: Int, recipient: Int, whoseTurn: Bool){ // team is healing someone
        
        if whoseTurn == true {
            
            let newLifeStrength: Int = ((teamFactory.arrayTeamFirst[recipient].lifeStrength) + 5)
            teamFactory.arrayTeamFirst[recipient].lifeStrength = newLifeStrength
            print("le hero que vous venez de soigner a à présent : \(teamFactory.arrayTeamFirst[recipient].lifeStrength)")
            
        }
        if whoseTurn == false {
            
            let newLifeStrength: Int = ((teamFactory.arrayTeamSecond[recipient].lifeStrength) + 5)
            teamFactory.arrayTeamSecond[recipient].lifeStrength = newLifeStrength
            print("le hero que vous venez de soigner a à présent : \(teamFactory.arrayTeamSecond[recipient].lifeStrength)")
        }
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
    
//    func checkNumberPlayerFirstTeam()-> Int {
//        var numberHeroesFirst: Int = 0 // number of heroes in First Team
//
//        for _ in 0..<teamFactory.arrayTeamFirst.count { // counting number of heroes in First Team
//            //            if teamFactory.arrayTeamFirst[element].teamNameAlias == "first" { // counting number of heroes in First Team
//            //                numberHeroesFirst += 1
//            //            }
//            numberHeroesFirst += 1
//        }
//        return numberHeroesFirst
//    }
   
//    func checkNumberPlayerSecondTeam()-> Int {
//
//        var numberHeroesSecond: Int = 0// number of heroes in Second Team
//        for _ in 0..<teamFactory.arrayTeamSecond.count { // counting number of heroes in First Team
//            //            if teamFactory.arrayTeamSecond[element].teamNameAlias == "second" { // counting number of heroes in Second Team
//            //                numberHeroesSecond += 1
//            //            }
//            numberHeroesSecond += 1
//        }
//        return numberHeroesSecond
//    }
    
//    func getHeroesTeam(whoseTurn: Bool,heroeRow: Int){ // getHeroesTeam will get the heroes of both team
//
//        // giving the Heroes in the team
//        //var arrayTeam = [Heroes]()
//
//        if whoseTurn == true { // will give to the player First in roll his possible Heroes
//
//            //print(teamFactory.arrayTeamFirst[heroeRow].heroName)
////            print(teamFactory.arrayTeamFirst[heroeRow].type)
////            print(teamFactory.arrayTeamFirst[heroeRow].lifeStrength)
////            print(teamFactory.arrayTeamFirst[heroeRow].armorStrength)
//
////            print("*******************************************************")
////            print("\n** Heroes name : \(teamFactory.arrayTeamFirst[heroeRow].heroName)**")
////            print("\n****************************************************************************")
////            print("\n** Hero Type : \(teamFactory.arrayTeamFirst[heroeRow].type)         **")
////            print("\n****************************************************************************"
////                + "\n** LifeStrenght : \(teamFactory.arrayTeamFirst[heroeRow].lifeStrength) **"
////                + "\n****************************************************************************"
////                + "\n** ArmorStrength : \(teamFactory.arrayTeamFirst[heroeRow].armorStrength) **")
//////                + "\****************************************************************************
//////                + "\** LifeStrenght : Value **
//////                + "\****************************************************************************
//////                + "\** LifeStrenght : Value **
//////                + "\****************************************************************************
////            arrayTeam = teamFactory.arrayTeamFirst
//            }
//
//
//
//        if whoseTurn == false { // will give to the player Second in roll his possible Heroes
//
////            print(teamFactory.arrayTeamSecond[heroeRow].type)
////            print(teamFactory.arrayTeamSecond[heroeRow].lifeStrength)
////            print(teamFactory.arrayTeamSecond[heroeRow].armorStrength)
////            print(teamFactory.arrayTeamSecond[heroeRow].heroName)
//
////            print("*******************************************************")
////            print("\n** Heroes name : \(teamFactory.arrayTeamSecond[heroeRow].heroName)**")
////            print("\n****************************************************************************")
////            print("\n** Hero Type : \(teamFactory.arrayTeamSecond[heroeRow].type)         **")
////            print("\n****************************************************************************"
////                + "\n** LifeStrenght : \(teamFactory.arrayTeamSecond[heroeRow].lifeStrength) **"
////                + "\n****************************************************************************"
////                + "\n** ArmorStrength : \(teamFactory.arrayTeamSecond[heroeRow].armorStrength) **")
////            arrayTeam = teamFactory.arrayTeamSecond
//        }
////        return arrayTeam
//
//
//    }
    
//    func getRecipientsTeam(whoseTurn: Bool,heroeRow: Int) {  //  getRecipientsTeam
//        // giving the defendants in the adverse team
//        //        var arrayDefendants = [Heroes]()
//        
//        if whoseTurn == true  { // will give to the player First in roll his possible Heroes
//            
//            print(teamFactory.arrayTeamFirst[heroeRow].type)
//            print(teamFactory.arrayTeamFirst[heroeRow].lifeStrength)
//            print(teamFactory.arrayTeamFirst[heroeRow].armorStrength)
//            print(teamFactory.arrayTeamFirst[heroeRow].heroName)
//            
//            
//        }
//        
//        if whoseTurn == false { // will give to the player Second in roll his possible Heroes
//            
//            print(teamFactory.arrayTeamSecond[heroeRow].type)
//            print(teamFactory.arrayTeamSecond[heroeRow].lifeStrength)
//            print(teamFactory.arrayTeamSecond[heroeRow].armorStrength)
//            print(teamFactory.arrayTeamSecond[heroeRow].heroName)
//            
//        }
//        
//    }
    
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
