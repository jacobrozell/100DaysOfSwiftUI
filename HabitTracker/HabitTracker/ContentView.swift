//
//  ContentView.swift
//  HabitTracker
//
//  Created by Jacob Rozell on 6/24/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct Activity {
    var title: String
    var description: String
    var completedCount = 0
}

class ActivityStorage: ObservableObject {
    @Published var activities: [Activity] = []

    init(activities: [Activity]) {
        self.activities = activities
    }
}

struct ContentView: View {
    @ObservedObject var storage = ActivityStorage(activities: [])
    @State private var showingAddView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(storage.activities, id: \.title) { activity in
                    HStack {
                        Text(activity.title)
                        Text(activity.description)
                    }
                }
                .onDelete(perform: deleteActivity)
            }

            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                    self.showingAddView = true
                }) {
                    Image(systemName: "plus")
                })

            .sheet(isPresented: $showingAddView) {
                AddView(storage: self.storage)
            }
            
        }
    }

    func deleteActivity(at offsets: IndexSet) {
        storage.activities.remove(atOffsets: offsets)
    }
}

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
        ScrollView {
            VStack {
                Text("Add Activity")
                    .font(.largeTitle)

                HStack {
                    Text("Activity Title")
                    TextField("Title", text: $title)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack {
                    Text("Activity Description")
                    TextField("Description", text: $desc)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
//                HStack {
//                    Text("Activity Count")
//                    // add some sort of picker?
//                }

                Spacer()

                Button(action: {
                    self.storage.activities.append(
                        Activity(
                            title: self.title,
                            description: self.desc,
                            completedCount: self.count)
                    )
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add Habit")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
