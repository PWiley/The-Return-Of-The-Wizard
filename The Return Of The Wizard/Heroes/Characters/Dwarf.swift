//
//  Dwarf.swift
//  The Return Of The Wizard
//
//  Created by Patrick Wiley on 22/08/2018.
//  Copyright © 2018 Patrick Wiley. All rights reserved.
//

import Foundation


class Dwarf: Heroes { // setting proporties for Dwarf

    init() {    // initialization of the proporties
        
        super.init(lifeStrength: 50, shotStrength: 20, armorStrength: 4, typeHero: TypeHero.Dwarf, equipment : Equipment.Axe)
    }
}


