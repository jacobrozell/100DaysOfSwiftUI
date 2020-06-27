//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Jacob Rozell on 6/27/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct Address {
    
}

struct AddressView: View {
    @ObservedObject var orderStorage: OrderStorage
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderStorage.order.name)
                TextField("Street Address", text: $orderStorage.order.streetAddress)
                TextField("City", text: $orderStorage.order.city)
                TextField("Zip", text: $orderStorage.order.zip)
            }

            Section {
                NavigationLink(destination: CheckoutView(orderStorage: orderStorage)) {
                    Text("Check out")
                }
            }
            .disabled(!orderStorage.order.hasValidAddress)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(orderStorage: OrderStorage())
    }
}
