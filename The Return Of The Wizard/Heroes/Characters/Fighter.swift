//
//  Warrior.swift
//  The Return Of The Wizard
//
//  Created by Patrick Wiley on 22/08/2018.
//  Copyright © 2018 Patrick Wiley. All rights reserved.
//

import Foundation


class Fighter: Heroes { // setting proporties for Warrior

    init() {     // initialization of Warrior proporties
        
        super.init(lifeStrength: 100, shotStrength: 10, armorStrength: 5, typeHero: TypeHero.Fighter, equipment : Equipment.Sword)
    }
}
