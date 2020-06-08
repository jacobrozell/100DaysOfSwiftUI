//
//  ContentView.swift
//  AnimationSandbox
//
//  Created by Jacob Rozell on 6/5/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 0.0
    @State private var enabled = false
    
    var body: some View {
        Button("Tap Me") {
            self.enabled.toggle()
        }
        .padding(50)
        .frame(width: 200, height: 200)
        .foregroundColor(.white)
        .background(enabled ? Color.blue : Color.red)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
