//
//  Activity.swift
//  HabitTracker
//
//  Created by Jacob Rozell on 6/24/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import Foundation
import SwiftUI

enum GoalType: String, Codable {
    case reoccuring
    case oneAndDone
}

struct Goal: Codable, Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var goalType: GoalType = .reoccuring

    // Reocurring
    var completedCount: Int = 0
    var completedGoal: Int = 1
    var progress: Double {
        return Double(completedCount / completedGoal)
    }

    // One and Done / Daily / Weekly
    var completed: Bool = false
}

class ActivityStorage: ObservableObject {
    @Published var activities = [Goal]() {
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

            if let decoded = try? decoder.decode([Goal].self, from: json) {
                self.activities = decoded
                return
            }
        }

        self.activities = []
    }
}
