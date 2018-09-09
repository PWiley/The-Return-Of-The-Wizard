//
//  Team.swift
//  The Return Of The Wizard
//
//  Created by Patrick Wiley on 22/08/2018.
//  Copyright © 2018 Patrick Wiley. All rights reserved.
//

import Foundation



// declaration of dictionaryTeam [String, Heroes]



class Team {
    
    var arrayTeamFirst : [Heroes] = [] // declaration of arrayTeamFirst [Heroes] for First Team
    var arrayTeamSecond : [Heroes] = [] // declaration of arrayTeamFirst [Heroes] for Second Team
    var arrayWithoutWizard : [Heroes] = [] // declaration of rrayWithoutWizard ( without any Wizard selected as dispenser
    
    
    var teamName : String
    
    
    init() {
        
        self.teamName = "TeamName"
        
        //("\(TeamFactory().getStarterTeam())")
        }
    
    
}
  
    
    
    
