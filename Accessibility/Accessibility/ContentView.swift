//
//  ContentView.swift
//  Accessibility
//
//  Created by Jacob Rozell on 6/23/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var result = ""
    var body: some View {
        HStack(spacing: 15) {
            Text("Result:")
            TextField("Result", text: $result)
                .keyboardType(.numberPad)
                .accessibilityAction(named: Text("Clear")) {
                    self.clear()
            }
        }
        .padding()
    }

    func clear() {
        result = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
