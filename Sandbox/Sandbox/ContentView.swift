//
//  ContentView.swift
//  Sandbox
//
//  Created by Jacob Rozell on 6/25/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI
import SwiftUIX

struct AquilaForegroundColor: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
    }
}

struct AquilaBackgroundColor: ViewModifier {
    var color: Color

    init(payload: AnyJSON) {
        self.color = .red
    }

    func body(content: Content) -> some View {
        content
            .background(color)
    }
}


struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello World")
                .modifier(AquilaForegroundColor(color: Color.orange))

            ActivityIndicator()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
