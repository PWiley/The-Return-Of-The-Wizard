//
//  Colossus.swift
//  The Return Of The Wizard
//
//  Created by Patrick Wiley on 22/08/2018.
//  Copyright © 2018 Patrick Wiley. All rights reserved.
//

import Foundation


class Colossus: Heroes { // setting parameter for Colossus
    
    init() {     // initialization of the properties
        
        super.init(lifeStrength: 120, shotStrength: 5, armorStrength: 10, typeHeroe: "Colossus", heroeName: "", alive: true, equipment : Equipment.Hammer,teamNameAlias: "teamAlias")
    }
}

