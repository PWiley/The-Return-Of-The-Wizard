//
//  Weapons.swift
//  The Return Of The Wizard
//
//  Created by Patrick Wiley on 22/08/2018.
//  Copyright © 2018 Patrick Wiley. All rights reserved.
//

import Foundation


enum Equipment: Int {

    case Axe = 8 // Axe effect at 8 points
    case Hammer = 6 // Hammer effect at 6 points
    case Sword = 5 // Sword effect at 6 points
    case Scepter = 7 // Scepter effect at 6 points
    
    func effect() -> Int {
        
     return self.rawValue
    }
    
    
}



