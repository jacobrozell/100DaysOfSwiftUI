//
//  ContentView.swift
//  HabitTracker
//
//  Created by Jacob Rozell on 6/24/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var storage = ActivityStorage(activities: [])
    @State private var showingAddView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(storage.activities, id: \.title) { activity in
                    NavigationLink(destination: HabitView(storage: self.storage, activity: activity)) {
                        HStack {
                            VStack {
                                Text(activity.title)
                                Text(activity.description)
                            }

                            Spacer()

                            Text("\(activity.completedCount)")
                        }
                    }
                }
                .onDelete(perform: deleteActivity)
            }

            .navigationBarTitle("My Habits")

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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
