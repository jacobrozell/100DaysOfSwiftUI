//
//  ContentView.swift
//  Moonshot
//
//  Created by Jacob Rozell on 6/17/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct CustomText: View {
    var text: String

    var body: some View {
        Text(text)
    }

    init(_ text: String) {
        print("Creating...")
        self.text = text
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                ForEach(0..<100) {
                    CustomText("Item \($0)")
                        .font(.largeTitle)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
