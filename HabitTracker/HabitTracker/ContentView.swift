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

                Spacer()

                VStack {
                    Text("Goal: \(activity.completedGoal)")
                    Text("Actual: \(activity.completedCount)")
                }
            }
        }
    }
}

// MARK: Custom Modifiers
struct makeCircle: ViewModifier {
    var padding: CGFloat = 12
    var cornerRadius: CGFloat = 16

    func body(content: Content) -> some View {
        content
            .padding(.all, padding)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(cornerRadius)
            .clipped()
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
                .modifier(makeCircle(padding: 6, cornerRadius: 12)),

            trailing: Button(action: {
                self.showingAddView = true
            }) {
                Image(systemName: "plus")
                    .modifier(makeCircle(padding: 8, cornerRadius: 20))
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
