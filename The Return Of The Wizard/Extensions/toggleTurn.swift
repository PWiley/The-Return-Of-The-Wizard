//
//  toggleTurn.swift
//  The Return Of The Wizard
//
//  Created by Patrick Wiley on 15/09/2018.
//  Copyright © 2018 Patrick Wiley. All rights reserved.
//

import Foundation


extension Bool {       // will toggle the player turn either player One or player Two
    mutating func toggle() {
        self = !self
    }
}
