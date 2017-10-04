//
//  CoffeeUser.swift
//  CloudCoffee
//
//  Created by Vinícius Cano Santos on 04/10/17.
//  Copyright © 2017 Nicholas Babo. All rights reserved.
//

import Foundation

enum CoffeeUserKey: String {
    case name
    case coffees
}

struct CoffeeUser {
    let name: String
    let coffees: [Coffee]
    
    func string() -> String {
        return "\(name) - \(coffees)"
    }
}
