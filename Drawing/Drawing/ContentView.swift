//
//  ContentView.swift
//  Drawing
//
//  Created by Jacob Rozell on 6/18/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0

    func path(in rect: CGRect) -> Path {

        // SwiftUI draws the shape the opposite of what we would expect
        // So, we manually flip the logic to get it to behave the way we would expect
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: rect.width / 2 - insetAmount,
            startAngle: modifiedStart,
            endAngle: modifiedEnd,
            clockwise: !clockwise
        )

        return path
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct ContentView: View {
    @State private var num = 0

    var body: some View {
        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
            .strokeBorder(Color.blue, lineWidth: 20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
