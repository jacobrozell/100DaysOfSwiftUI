//
//  AddView.swift
//  iExpense
//
//  Created by Jacob Rozell on 6/16/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var showError = false
    static let types = ["Business", "Peronsal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)

            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(leading: EditButton(), trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.showError = true
                }
            })
                .alert(isPresented: $showError) {
                    Alert(title: Text("Error!"), message: Text("Please fill out all fields or check that amount is a number!"), dismissButton: .default(Text("Dismiss")))
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
