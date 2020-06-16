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
    @Published var items = [ExpenseItem]()
}
