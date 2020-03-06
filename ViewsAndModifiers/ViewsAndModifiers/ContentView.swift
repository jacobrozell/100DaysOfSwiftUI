//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Jacob Rozell on 3/6/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

// Custom View
struct BlueTitleView: View {
    let text: String
    
    var body: some View {
        Text(text)
            . font(.largeTitle)
            .padding()
            .foregroundColor(Color.blue)
            .clipShape(Capsule())
    }
}

// View Modifier
struct blueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(.largeTitle)
        .padding()
        .foregroundColor(Color.blue)
        .clipShape(Capsule())
    }
}

extension View {
    func blueTitleStyle() -> some View {
        self.modifier(blueTitle())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            BlueTitleView(text: "Hello World!")
            Text("HelloWorld2")
                .blueTitleStyle()
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
