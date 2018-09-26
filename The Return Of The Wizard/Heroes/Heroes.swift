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
    
    var lifeStrength: Int // points of life
    var shotStrength: Int // power of shot
    var armorStrength: Int // level of protection
    var type: HeroType // it will be set by the player
    var heroName: String // it will be set by the player
    var alive: Bool // alive or not
    var equipment: Equipment // type of equipement
    
    
    
    init(lifeStrength: Int, shotStrength: Int, armorStrength: Int, typeHero: HeroType, heroName: String = "", alive: Bool = true, equipment: Equipment) {
        
        self.lifeStrength = lifeStrength
        self.shotStrength = shotStrength
        self.armorStrength = armorStrength
        self.type = typeHero
        self.heroName = heroName
        self.alive = alive
        self.equipment = equipment
        
    }
}

enum HeroType {
    case Fighter
    case Wizard
    case Colossus
    case Dwarf
}

