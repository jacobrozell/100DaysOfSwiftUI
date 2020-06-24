//
//  AddView.swift
//  HabitTracker
//
//  Created by Jacob Rozell on 6/24/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var storage: ActivityStorage
    @State private var title = ""
    @State private var desc = ""
    @State private var completedCount = 0
    @State private var completedGoal = 1

    init(storage: ActivityStorage) {
        self.storage = storage
    }

    var body: some View {
        NavigationView {
                VStack {
                    Spacer().frame(minWidth: 15, idealWidth: 15, maxWidth: 20, minHeight: 15, idealHeight: 10, maxHeight: 10)

                    VStack(alignment: .leading) {
                        TextField("Title", text: $title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 10)

                        TextField("Description", text: $desc)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 10)

                        Stepper("Times Completed: \(completedCount)", value: $completedCount, in: 0...100)
                            .padding(.horizontal, 10)

                        Stepper("Goal: \(completedGoal)", value: $completedGoal, in: 1...100)
                            .padding(.horizontal, 10)
                    }

                    Spacer()

                    Button(action: {
                        // Add activity
                        self.storage.activities.append(
                            Activity(
                                title: self.title,
                                description: self.desc,
                                completedCount: self.completedCount,
                                completedGoal: self.completedGoal)
                        )

                        // Dismiss AddView
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add Habit")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                    }
                }
            .navigationBarTitle("Add Activity")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(storage: ActivityStorage())
    }
}
