//
//  Wizard.swift
//  The Return Of The Wizard
//
//  Created by Patrick Wiley on 22/08/2018.
//  Copyright © 2018 Patrick Wiley. All rights reserved.
//

import Foundation


class Wizard: Heroes { // setting proporties for Wizard
    
    init() {     // initialization of the proporties
        
        super.init(lifeStrength: 80, shotStrength: 20, armorStrength: 5, name: "Wizard", heroeName: "", alive: true, equipment : Equipment.Scepter,teamAlias: "teamAlias")
    }
    
}
