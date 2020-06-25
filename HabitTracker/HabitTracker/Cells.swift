//
//  Cells.swift
//  HabitTracker
//
//  Created by Jacob Rozell on 6/25/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct ReoccurringCellView: View {
    @ObservedObject var storage: ActivityStorage
    var activity: Goal

    var body: some View {
        NavigationLink(destination: ReoccurringGoalView(storage: self.storage, activity: activity)) {

            HStack {
                Text(activity.title)
                    .font(.headline)

                Spacer()

                VStack {
                    Text("Goal: \(activity.completedGoal)")
                    Text("Actual: \(activity.completedCount)")
                }
            }
        }
    }
}

struct SingleCellView: View {
    @ObservedObject var storage: ActivityStorage
    var activity: Goal

    var body: some View {
        NavigationLink(destination: SingleGoalView(storage: self.storage, goal: activity)) {

            HStack {
                Text(activity.title)
                    .font(.headline)

                Spacer()
            }
        }
    }
}
