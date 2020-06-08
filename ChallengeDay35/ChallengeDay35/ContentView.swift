//
//  ContentView.swift
//  ChallengeDay35
//
//  Created by Jacob Rozell on 6/5/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct Question {
    var text: String = ""
    var answer: Int = 0
}

// MARK: Main View
struct ContentView: View {
    var body: some View {
        NavigationView {
            SettingsForm()
                
        .navigationBarTitle("Multiplication")
        }
    }
}

// MARK: Settings State
struct SettingsForm: View {
    let questionChoices = ["5", "10", "15", "20"]
    @State private var tableToUse = 2
    @State private var selectedIndex = 0
    
    var body: some View {
        VStack {
            Form {
                Section(header:
                    Text("Choose Table")
                        .font(.headline)) {
                            
                    Stepper(value: $tableToUse, in: 2...12) {
                        Text("Table: \(tableToUse)")
                    }
                            
                }
                
                Section(header:
                    Text("Choose Question Amount")
                        .font(.headline)) {
                            
                    Picker("Questions", selection: $selectedIndex) {
                        ForEach(0 ..< questionChoices.count) {
                            Text("\(self.questionChoices[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Text("Questions: \(questionChoices[selectedIndex])")
                }
            }
            StartButton(tableToUse: $tableToUse, selectedIndex: $selectedIndex)
        }
    }
}

struct StartButton: View {
    @Binding var tableToUse: Int
    @Binding var selectedIndex: Int
    let questionChoices = ["5", "10", "15", "20"]
    
    var body: some View {
        VStack {
            NavigationLink(destination: GameView()) {
                HStack {
                    Text("Start Game!")
                }.padding(10.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 16.0)
                        .stroke(lineWidth: 1.0)
                        .animation(.default)
                )
            }
        }
        .onDisappear() {
            self.generateQuestions()
        }
    }
    
    func generateQuestions() {
        var questions: [Question] = []
        let questionAmount: Int = Int(questionChoices[selectedIndex]) ?? 5
        for i in 1...questionAmount {
            questions.append(Question(text: "\(tableToUse) X \(i)", answer: i * tableToUse))
        }
        
        #warning("Remove this")
        for i in questions {
            print(i)
        }
    }
}

// MARK: Game State
struct GameView: View {
    var body: some View {
        Text("GAMEVIEW")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

