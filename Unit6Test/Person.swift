//
//  Person.swift
//  Unit6Test
//
//  Created by Seth Danner on 7/2/18.
//  Copyright © 2018 Seth Danner. All rights reserved.
//

import Foundation

class Person: Codable {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Person: Equatable {
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
}
