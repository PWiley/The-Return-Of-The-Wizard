//
//  Warrior.swift
//  The Return Of The Wizard
//
//  Created by Patrick Wiley on 22/08/2018.
//  Copyright © 2018 Patrick Wiley. All rights reserved.
//

import Foundation


class Warrior: Heroes { // setting proporties for Warrior

    init() {     // initialization of Warrior proporties
        
        super.init(lifeStrength: 100, shotStrength: 20, armorStrength: 10, name: "Warrior", teamName: "", alive: true, equipment : Equipment.Sword)
    }
}
