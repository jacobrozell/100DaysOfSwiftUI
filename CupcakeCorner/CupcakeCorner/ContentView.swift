//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Jacob Rozell on 6/27/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var email = ""

    var disabledForm: Bool {
        username.count < 7 || !isValidEmail(email)
    }

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create Account") {
                    print("Creating account...")
                }
            }
            .disabled(disabledForm)
        }
    }

    func isValidEmail(_ email: String) -> Bool {
        if email.isEmpty {
            return false
        }

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
