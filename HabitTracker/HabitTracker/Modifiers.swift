//
//  Modifiers.swift
//  HabitTracker
//
//  Created by Jacob Rozell on 6/25/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct makeCircle: ViewModifier {
    var padding: CGFloat = 12
    var cornerRadius: CGFloat = 16

    func body(content: Content) -> some View {
        content
            .padding(.all, padding)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(cornerRadius)
            .clipped()
    }
}
