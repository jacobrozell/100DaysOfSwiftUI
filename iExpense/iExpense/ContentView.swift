//
//  ContentView.swift
//  iExpense
//
//  Created by Jacob Rozell on 6/10/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

class User: ObservableObject {
    @Published var fName: String = "Jacob"
    @Published var lName: String = "Rozell"
}

struct ContentView: View {
    @ObservedObject var user = User()
    var body: some View {
        VStack {
            Text("\(user.lName), \(user.fName)")
            TextField("First Name", text: $user.fName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Last Name", text: $user.lName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
