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
    @State private var count = 0

    init(storage: ActivityStorage) {
        self.storage = storage
    }

    var body: some View {
        Form {
            VStack {
                Text("Add Activity")
                    .font(.largeTitle)

                Section {
                    TextField("Title", text: $title)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                Section {
                    TextField("Description", text: $desc)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

//                Section {
//                    Text("Activity Count")
//                    // add some sort of picker?
//                }

                Spacer()

                Button(action: {
                    // Add activity
                    self.storage.activities.append(
                        Activity(
                            title: self.title,
                            description: self.desc,
                            completedCount: self.count)
                    )

                    // Dismiss AddView
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add Habit")
                        .padding()

                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(storage: ActivityStorage(activities: [
            Activity(
                title: "Ride Bike",
                description: "Just a couple miles",
                completedCount: 0)
        ]))
    }
}
