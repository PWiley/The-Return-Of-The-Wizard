//
//  Heroes.swift
//  The Return Of The Wizard
//
//  Created by Patrick Wiley on 22/08/2018.
//  Copyright © 2018 Patrick Wiley. All rights reserved.
//

import Foundation


// setting parameter for each Character

class Heroes {
    
    // declaration properties
    
    var lifeStrength: Int
    var shotStrength: Int
    var armorStrength: Int
    var type: String // it will be set by the player
    var heroeName: String // it will be set by the player
    var alive: Bool
    var equipment: Equipment
    var teamNameAlias: String
    
    init(lifeStrength: Int, shotStrength: Int, armorStrength: Int, typeHeroe: String, heroeName: String, alive: Bool, equipment: Equipment, teamNameAlias: String ) {
        
        self.lifeStrength = lifeStrength
        self.shotStrength = shotStrength
        self.armorStrength = armorStrength
        self.type = typeHeroe
        self.heroeName = heroeName
        self.alive = alive
        self.equipment = equipment
        self.teamNameAlias = teamNameAlias
    }
}


