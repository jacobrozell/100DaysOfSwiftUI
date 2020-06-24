//
//  ContentView.swift
//  HabitTracker
//
//  Created by Jacob Rozell on 6/24/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI


// MARK: CellView
struct CellView: View {
    @ObservedObject var storage: ActivityStorage
    var activity: Activity

    var body: some View {
        NavigationLink(destination: HabitView(storage: self.storage, activity: activity)) {
            HStack {

                Text(activity.title)
                    .font(.headline)
                    .fontWeight(.bold)

                Spacer()

                VStack {
                    Text("Goal: \(activity.completedGoal)")
                    Text("Actual: \(activity.completedCount)")
                }
            }
        }
    }
}

// MARK: Main View
struct ContentView: View {
    @ObservedObject var storage = ActivityStorage()
    @State private var showingAddView = false

    var body: some View {
        NavigationView {

            // List
            List {
                ForEach(storage.activities) { activity in
                    CellView(storage: self.storage, activity: activity)
                }
                .onDelete(perform: deleteActivity)
            }

            // Nav Customizations
            .navigationBarTitle("My Habits")

            .navigationBarItems(
                leading: EditButton()
                    .padding(.all, 6)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(28),
                trailing: Button(action: {
                    self.showingAddView = true
                }) {
                    Image(systemName: "plus")
                        .padding(.all, 10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                })

            // Sheet
            .sheet(isPresented: $showingAddView) {
                AddView(storage: self.storage)
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
