//
//  isAnInt.swift
//  The Return Of The Wizard
//
//  Created by Patrick Wiley on 12/09/2018.
//  Copyright © 2018 Patrick Wiley. All rights reserved.
//

import Foundation


extension String { // controls the fact that the value imput is cast in int
    var isInt: Bool {
        return Int(self) != nil
    }
}

extension Bool {       // will toggle the player turn either player One or player Two
    mutating func toggle() {
        self = !self
    }
}
extension Int { // gives a value vy random for setting the new equipement
    static func random(max: Int) -> Int {
        let rnd = Int(arc4random_uniform(UInt32(max) + 1))
        return rnd
    }
}
