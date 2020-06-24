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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(storage: ActivityStorage(activities: [
            Activity(
                title: "Ride Bike",
                description: "Just a couple miles",
                completedCount: 0)]),
          activity:
            Activity(
                title: "Ride Bike",
                description: "Just a couple miles",
                completedCount: 0))
    }
}
