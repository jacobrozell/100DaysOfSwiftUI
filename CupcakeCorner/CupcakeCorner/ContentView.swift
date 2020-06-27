//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Jacob Rozell on 6/27/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var orderStorage = OrderStorage()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $orderStorage.order.type) {
                        ForEach(0..<OrderStorage.Order.types.count, id: \.self) {
                            Text(OrderStorage.Order.types[$0])
                        }
                    }

                    Stepper(value: $orderStorage.order.quantity, in: 3...20) {
                        Text("Number of cakes: \(orderStorage.order.quantity)")
                    }
                }

                Section {
                    Toggle(isOn: $orderStorage.order.sepcialRequestEnabled.animation()) {
                        Text("Any special reuests?")
                    }

                    if orderStorage.order.sepcialRequestEnabled {
                        Toggle(isOn: $orderStorage.order.extraFrosting) {
                            Text("Add extra frosting")
                        }

                        Toggle(isOn: $orderStorage.order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }

                Section {
                    NavigationLink(destination: AddressView(orderStorage: orderStorage)) {
                        Text("Delivery details")
                    }
                }
            }
        .navigationBarTitle("CupcakeCorner")
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
