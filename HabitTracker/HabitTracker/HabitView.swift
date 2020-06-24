//
//  HabitView.swift
//  HabitTracker
//
//  Created by Jacob Rozell on 6/24/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct HabitView: View {
    @ObservedObject var storage: ActivityStorage
    var activity: Activity

    var body: some View {
        VStack {
            Text("\(activity.title)")

            Text("\(activity.description)")

            Text("\(activity.completedCount)")

            Text("\(activity.completedGoal)")

            Spacer()
        }
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(storage: ActivityStorage(), activity:
            Activity(
                title: "Ride Bike",
                description: "Just a couple miles",
                completedCount: 0))
    }
}
