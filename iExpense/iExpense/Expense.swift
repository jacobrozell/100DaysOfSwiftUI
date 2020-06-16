//
//  Expense.swift
//  iExpense
//
//  Created by Jacob Rozell on 6/15/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()

            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        // Grab cached data
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()

            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }

        // Init to empty
        self.items = []
    }
}
