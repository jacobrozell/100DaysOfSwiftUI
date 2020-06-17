//
//  Mission.swift
//  Moonshot
//
//  Created by Jacob Rozell on 6/17/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {

    // Internal Struct
    struct CrewRole: Codable {
        let name: String
        let role: String
        let launchDate: String?
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String

    // Computed Properties
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }

    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }

    var crewIds: [String] {
        var ids = [String]()
        for member in crew {
            ids.append(member.name)
        }
        return ids
    }
}
