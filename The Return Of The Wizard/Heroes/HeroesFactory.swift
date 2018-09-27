//
//  HeroesFactory.swift
//  The Return Of The Wizard
//
//  Created by Patrick Wiley on 30/08/2018.
//  Copyright © 2018 Patrick Wiley. All rights reserved.
//

import Foundation

/*** allows to create the hero ask by the player ***/
class HeroesFactory {
    
    func getHeroe(heroesInt : String) -> Heroes? {
        
        switch heroesInt {
        case "1" :
            return Fighter()
        case "2" :
            return Wizard()
        case "3" :
            return Colossus()
        case "4" :
            return Dwarf()
        default :
            return nil
        }
    }
}
