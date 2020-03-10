//
//  ContentView.swift
//  BetterRestSandbox
//
//  Created by Jacob Rozell on 3/9/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%.g") hours")
                }
                .padding(8)
                
                Form {
                    Section(header: Text("Wake up time")) {
                        DatePicker("", selection: $wakeUp, in: Date()..., displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    }
                }
            }
            .navigationBarTitle("Sandbox")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
