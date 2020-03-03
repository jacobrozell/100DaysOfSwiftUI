//
//  ContentView.swift
//  ChallengeDay19Watch Extension
//
//  Created by Jacob Rozell on 3/3/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var unit1 = 0
    @State private var unit2 = 0
    @State private var value = ""
    
    let units = ["Milliliters", "Liters", "Cups", "Pints", "Gallons"]
    
    var result: Double {
        let unit1String = units[unit1]
        let unit2String = units[unit2]
        let valueAsDouble = Double(value) ?? 0.0
        
        // Find Amount for Input Unit
        let measurement1: Measurement<UnitVolume>
        switch(unit1String) {
        case "Milliliters":
            measurement1 = Measurement(value: valueAsDouble, unit: UnitVolume.milliliters)
        case "Liters":
            measurement1 = Measurement(value: valueAsDouble, unit: UnitVolume.liters)
        case "Cups":
            measurement1 = Measurement(value: valueAsDouble, unit: UnitVolume.cups)
        case "Pints":
            measurement1 = Measurement(value: valueAsDouble, unit: UnitVolume.pints)
        case "Gallons":
            measurement1 = Measurement(value: valueAsDouble, unit: UnitVolume.gallons)
        default:
            measurement1 = Measurement(value: valueAsDouble, unit: UnitVolume.milliliters)
            return 0.0
        }
        
        // Find Amount for Output Unit based on on Input Unit
        let measurement2: Measurement<UnitVolume>
        switch(unit2String) {
        case "Milliliters":
            measurement2 = measurement1.converted(to: .milliliters)
        case "Liters":
            measurement2 = measurement1.converted(to: .liters)
        case "Cups":
            measurement2 = measurement1.converted(to: .cups)
        case "Pints":
            measurement2 = measurement1.converted(to: .pints)
        case "Gallons":
            measurement2 = measurement1.converted(to: .gallons)
        default:
            measurement2 = measurement1.converted(to: .milliliters)
            return 0.0
        }

        
        return measurement2.value
    }
   
    var body: some View {
        Form {
            Section(header: Text("1. Pick Input Unit")) {
                Picker("Input Unit", selection: $unit1) {
                    ForEach(0 ..< units.count) {
                        Text("\(self.units[$0])")
                    }
                }
            }
            
            Section(header: Text("2. Enter Value")) {
                TextField("Value", text: $value)
            }
        
            Section(header: Text("3. Pick Output Unit")) {
                Picker("Output Unit", selection: $unit2) {
                    ForEach(0 ..< units.count) {
                        Text("\(self.units[$0])")
                    }
                }
            }
            
            Section(header: Text("4. Result")) {
                Text("\(result, specifier: "%.3f")")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
