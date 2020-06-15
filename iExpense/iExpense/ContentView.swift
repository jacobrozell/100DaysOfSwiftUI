//
//  ContentView.swift
//  iExpense
//
//  Created by Jacob Rozell on 6/10/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State private var taps = UserDefaults.standard.integer(forKey: "taps")
    var body: some View {
        VStack(spacing: 50) {
            Text("Taps: \(taps)")
                .font(.largeTitle)

            Spacer()

            Button("Tap Me") {
                self.taps += 1
                UserDefaults.standard.set(self.taps, forKey: "taps")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
