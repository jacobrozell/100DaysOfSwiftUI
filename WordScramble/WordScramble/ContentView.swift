//
//  ContentView.swift
//  WordScramble
//
//  Created by Jacob Rozell on 3/18/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            Section(header: Text("Section 1")) {
                Text("Static row 1")
                Text("Static row 2")
            }
            
            Section(header: Text("Section 2")) {
                ForEach(0..<5) {
                    Text("Text row \($0)")
                }
            }
            
            Section(header: Text("Section 3")) {
                Text("Static row 3")
                Text("Static row 24")
            }
            
        }
        .listStyle(GroupedListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
