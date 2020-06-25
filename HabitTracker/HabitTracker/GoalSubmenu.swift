//
//  GoalSubmenu.swift
//  HabitTracker
//
//  Created by Jacob Rozell on 6/25/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct GoalSubmenu: View {
    @ObservedObject var storage: ActivityStorage
    @State private var reoccurringPresented = false
    @State private var singlePresented = false

    var body: some View {
        VStack(spacing: 25) {
            Button(action: {
                self.reoccurringPresented.toggle()
            }) {
                Text("Add Reoccurring Goal (Daily/Weekly)")
                    .frame(width: UIScreen.main.bounds.width/1.5)
                    .modifier(makeCircle())
            }
            .sheet(isPresented: $reoccurringPresented) {
                AddReoccurringGoalView(storage: self.storage)
            }

            Button(action: {
                self.singlePresented.toggle()
            }) {
                Text("Add Single Goal")
                    .frame(width: UIScreen.main.bounds.width/1.5)
                    .modifier(makeCircle())
            }
            .sheet(isPresented: $singlePresented) {
                AddSingleGoal(storage: self.storage)
            }
        }
    }
}

