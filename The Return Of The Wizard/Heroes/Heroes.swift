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
    var name: String // it will be set by the player
    var heroeName: String // it will be set by the program
    var alive: Bool
    var equipment: Equipment
    
    init(lifeStrength: Int, shotStrength: Int, armorStrength: Int, name: String, heroeName: String, alive: Bool, equipment : Equipment) {
        
        self.lifeStrength = lifeStrength
        self.shotStrength = shotStrength
        self.armorStrength = armorStrength
        self.name = name
        self.heroeName = heroeName
        self.alive = alive
        self.equipment = equipment
    }
}


