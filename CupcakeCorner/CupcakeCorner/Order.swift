//
//  Order.swift
//  CupcakeCorner
//
//  Created by Jacob Rozell on 6/27/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

class OrderStorage: Codable, ObservableObject {

    // MARK: - Order Struct
    struct Order: Codable {

        // Type
        static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
        var type = 0

        // Quantity
        var quantity = 3

        // Special Request Properties
        var sepcialRequestEnabled = false {
            didSet {
                if !sepcialRequestEnabled {
                    extraFrosting = false
                    addSprinkles = false
                }
            }
        }
        var extraFrosting = false
        var addSprinkles = false

        // Address Properties
        var name = ""
        var streetAddress = ""
        var city = ""
        var zip = ""

        var hasValidAddress: Bool {
            if name.trimmingCharacters(in: .whitespaces).isEmpty || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || city.trimmingCharacters(in: .whitespaces).isEmpty || zip.trimmingCharacters(in: .whitespaces).isEmpty {
                return false
            }

            return true
        }

        var cost: Double {
            var cost = Double(quantity) * 2
            cost += Double(type) / 2

            if extraFrosting {
                cost += Double(quantity)
            }

            if addSprinkles {
                cost += Double(quantity) / 2
            }

            return cost
        }
    }

    // MARK: - Variables
    @Published var order = Order()

    // Adds ability to init by using default values
    init() { }

    // MARK: - Codable Conformance
    enum CodingKeys: CodingKey {
        case order
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        order = try container.decode(Order.self, forKey: .order)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(order, forKey: .order)
    }
}
