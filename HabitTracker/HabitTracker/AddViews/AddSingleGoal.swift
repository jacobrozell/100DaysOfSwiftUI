//
//  AddSingleGoal.swift
//  HabitTracker
//
//  Created by Jacob Rozell on 6/24/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct AddSingleGoal: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var storage: ActivityStorage
    @State private var title = ""
    @State private var desc = ""
    @State private var completed = false

    init(storage: ActivityStorage) {
        self.storage = storage
    }

    var body: some View {
        NavigationView {
                VStack {
                    Divider()

                    VStack(alignment: .leading) {
                        TextField("Title", text: $title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 10)

                        TextField("Description", text: $desc)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 10)

                        Toggle(isOn: $completed) {
                            Text("Completed: ")
                        }
                        .padding(.horizontal, 10)
                    }

                    Spacer()

                    Button(action: {
                        // Add activity
                        self.storage.activities.append(
                            Goal(
                                title: self.title,
                                description: self.desc,
                                goalType: .oneAndDone)
                        )

                        // Dismiss AddView
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add Goal")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                    }

                    Divider()
                }
            .navigationBarTitle("Add Goal")
        }
    }
}

struct AddSingleGoal_Previews: PreviewProvider {
    static var previews: some View {
        AddSingleGoal(storage: ActivityStorage())
    }
}
