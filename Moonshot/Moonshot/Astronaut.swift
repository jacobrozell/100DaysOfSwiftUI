//
//  Astronaut.swift
//  Moonshot
//
//  Created by Jacob Rozell on 6/17/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import Foundation


/**
 Astronaut is parsed from astronauts.json.

 ## Members
 * `id` : String - the id of the astronaut
 * `name`: String - the astronaut's name
 * `description`: String - the description of the astronauts career

 ## Protocol Conformity
 * `Codable`
 * `Identifiable`

 */
struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}
