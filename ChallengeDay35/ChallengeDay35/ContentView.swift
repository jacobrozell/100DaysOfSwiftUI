//
//  ContentView.swift
//  ChallengeDay35
//
//  Created by Jacob Rozell on 6/5/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct Question: Identifiable {
    var id = UUID()
    
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
            
            NavigationLink(destination: GameView(tableToUse: tableToUse, selectedIndex: selectedIndex)) {
                HStack {
                    Text("Start Game!")
                }
                .padding(10.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 16.0)
                        .stroke(lineWidth: 1.0)
                        .animation(.default)
                )
            }
        }
    }
}

// MARK: Game State
struct GameView: View {
    @State private var questions: [Question] = []
    var tableToUse: Int
    var selectedIndex: Int
    let questionChoices = ["5", "10", "15", "20"]
    
    @State private var currentQuestion = 0
    @State private var correctIndex = 0
    
    init(tableToUse: Int, selectedIndex: Int) {
        self.tableToUse = tableToUse
        self.selectedIndex = selectedIndex
        questions = self.generateQuestions(tableValue: tableToUse, index: selectedIndex)
    }
    
    var body: some View {
        VStack {
            if !questions.isEmpty {
                Text("\(questions[currentQuestion].text)")
                
                HStack(spacing: 50) {
                    ForEach(1...3, id: \.self) { index in
                        Button(action: {
                            index == self.correctIndex ? self.correct() : self.incorrect()
                        }) {
                            Text("\(index == self.correctIndex ? self.questions[self.currentQuestion].answer :  self.questions[Int.random(in: 0...self.questionChoices.count)].answer) ")
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
    
    func generateQuestions(tableValue: Int, index: Int) -> [Question] {
        questions = []
        let questionAmount: Int = Int(questionChoices[index]) ?? 5
        for i in 1...questionAmount {
            questions.append(Question(text: "\(tableToUse) X \(i)", answer: i * tableToUse))
        }
        return questions.shuffled()
    }
    
    func askQuestion() {
        correctIndex = Int.random(in: 1...3)
    }
    
    func correct() {
        
    }
    
    func incorrect() {
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

