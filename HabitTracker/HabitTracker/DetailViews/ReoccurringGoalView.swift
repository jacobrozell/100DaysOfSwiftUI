//
//  HabitView.swift
//  HabitTracker
//
//  Created by Jacob Rozell on 6/24/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct ReoccurringGoalView: View {
    @ObservedObject var storage: ActivityStorage
    var activity: Goal

    var body: some View {
        VStack {
            Text("\(activity.title)")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .frame(width: UIScreen.main.bounds.width/1.25)
                .padding(.horizontal, 100)
                .lineLimit(3)

            Divider()
            
            // Card View -> Progress View
            VStack {
                Text("You've completed this \(activity.completedCount) times!")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.primary)

                Text("Hello")

            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.secondary, lineWidth: 5)
            )

            Spacer()

            Text(activity.description)

            Spacer()
        }
    }
}

struct ReoccurringGoalView_Previews: PreviewProvider {
    static var previews: some View {
        ReoccurringGoalView(storage: ActivityStorage(), activity: Goal(title: "TEST", description: "TEST")
        )
    }
}
