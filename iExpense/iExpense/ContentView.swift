//
//  ContentView.swift
//  iExpense
//
//  Created by Jacob Rozell on 6/10/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in

                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                        
                        if (0..<10).contains(item.amount) {
                            Text("$\(item.amount)")
                            .foregroundColor(.green)
                        } else if (10..<100).contains(item.amount) {
                            Text("$\(item.amount)")
                            .foregroundColor(.blue)
                        } else {
                            Text("$\(item.amount)")
                            .foregroundColor(.red)
                        }

                    }
                }
                .onDelete(perform: removeItems)
            }  
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddExpense = true
                }) {
                    Image(systemName: "plus")
                })
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
