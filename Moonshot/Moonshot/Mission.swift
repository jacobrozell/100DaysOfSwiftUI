//
//  Mission.swift
//  Moonshot
//
//  Created by Jacob Rozell on 6/17/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {

    // Internal Struct since we are only using it here
    struct CrewRole: Codable {
        let name: String
        let role: String
        let launchDate: String?
    }

    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
