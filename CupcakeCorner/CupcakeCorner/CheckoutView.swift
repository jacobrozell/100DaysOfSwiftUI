//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Jacob Rozell on 6/27/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var orderStorage: OrderStorage
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false


    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)

                    Text("Your total is $\(self.orderStorage.order.cost, specifier: "%.2f")")
                        .font(.title)

                    Button("Place order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func placeOrder() {
        // encode to data
        guard let encoded = try? JSONEncoder().encode(orderStorage) else {
            print("Failed to encode order")
            return
        }

        // URL request
        let url = URL(string: "https://reqres.in/api/cupcakes")!

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                self.alertTitle = "Error placing order!"
                self.alertMessage = "Check your internet connection"
                self.showingAlert = true
                return
            }

            if let decodedOrder = try? JSONDecoder().decode(OrderStorage.self, from: data) {
                self.alertTitle = "Thank you!"
                self.alertMessage = "Your order for \(decodedOrder.order.quantity)x \(OrderStorage.Order.types[decodedOrder.order.type].lowercased()) cupcakes is on its way!"
                self.showingAlert = true
            } else {
                print("Invalid response from the server")
            }

        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(orderStorage: OrderStorage())
    }
}
