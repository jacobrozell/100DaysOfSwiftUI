//
//  SingleGoalView.swift
//  HabitTracker
//
//  Created by Jacob Rozell on 6/25/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct SingleGoalView: View {
    @ObservedObject var storage: ActivityStorage
    var goal: Goal
    @State private var completed = false

    init(storage: ActivityStorage, goal: Goal) {
        self.storage = storage
        self.goal = goal
        self.completed = goal.completed
    }

    var body: some View {
        VStack {
            Text("\(goal.title)")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .frame(width: UIScreen.main.bounds.width/1.25)
                .padding(.horizontal, 100)
                .lineLimit(3)

            Text(goal.description)

            Toggle(isOn: $completed) {
                Text("Completed: ")
            }
            .padding(.horizontal, 10)

            Spacer()
        }
    }
}

struct SingleGoalView_Previews: PreviewProvider {
    static var previews: some View {
        SingleGoalView(storage: ActivityStorage(), goal: Goal(title: "TEST", description: "TEST")
        )
    }
}
