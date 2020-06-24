//
//  Activity.swift
//  HabitTracker
//
//  Created by Jacob Rozell on 6/24/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import Foundation
import SwiftUI

struct Activity: Codable, Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var completedCount: Int = 0
    var completedGoal: Int = 1

    var progress: Double {
        return Double(completedCount / completedGoal)
    }
}

class ActivityStorage: ObservableObject {
    @Published var activities = [Activity]() {
        didSet {
            let encoder = JSONEncoder()

            if let encoded = try? encoder.encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }

    init() {
        if let json = UserDefaults.standard.data(forKey: "Activities") {
            let decoder = JSONDecoder()

            if let decoded = try? decoder.decode([Activity].self, from: json) {
                self.activities = decoded
                return
            }
        }

        self.activities = []
    }
}
