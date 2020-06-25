//
//  ContentView.swift
//  HabitTracker
//
//  Created by Jacob Rozell on 6/24/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI


// MARK: Main View
struct ContentView: View {
    @ObservedObject var storage = ActivityStorage()
    @State private var showingAddView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(storage.activities) { activity in
                    if activity.goalType == .reoccuring {
                        ReoccurringCellView(storage: self.storage, activity: activity)
                    } else {
                        SingleCellView(storage: self.storage, activity: activity)
                    }
                }
                .onDelete(perform: deleteActivity)
            }

            .navigationBarTitle("My Goals")

            .navigationBarItems(
                leading: EditButton()
                    .modifier(makeCircle(padding: 6, cornerRadius: 12)),

                trailing: Button(action: {
                    self.showingAddView = true
                }) {
                    Image(systemName: "plus")
                        .modifier(makeCircle(padding: 8, cornerRadius: 20))
            })
            .sheet(isPresented: $showingAddView) {
                GoalSubmenu(storage: self.storage)
            }
        }
    }

    // MARK: Delete
    func deleteActivity(at offsets: IndexSet) {
        storage.activities.remove(atOffsets: offsets)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
