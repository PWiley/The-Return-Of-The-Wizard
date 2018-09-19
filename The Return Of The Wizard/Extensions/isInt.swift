//
//  isAnInt.swift
//  The Return Of The Wizard
//
//  Created by Patrick Wiley on 12/09/2018.
//  Copyright © 2018 Patrick Wiley. All rights reserved.
//

import Foundation


extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

extension Bool {       // will toggle the player turn either player One or player Two
    mutating func toggle() {
        self = !self
    }
}
