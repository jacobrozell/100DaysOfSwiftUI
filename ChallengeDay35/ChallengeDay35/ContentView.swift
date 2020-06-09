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

struct SettingsForm: View {
    let questionChoices = ["5", "10", "15", "20"]
    @State private var tableToUse = 2
    @State private var selectedIndex = 0
    
    @State private var questions: [Question] = []
    @State private var currentQuestion = -1     // Starts at 0 in askQuestion
    @State private var correctIndex = 0
    
    @State private var inSettings = true
    let questionRange = 1...3
    
    @State private var gameOverAlert = false
    
    @State private var questionsCorrect = 0
    @State private var maxQuestionsAsked = 0
    
    var body: some View {
        VStack {
            if inSettings {
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
                
                GameButton(action: {
                    self.startGame()
                }, text: "Start Game")
            }
            else {
                ZStack {
                    //LinearGradient(gradient: Gradient(colors: [.red, .blue, .orange]), startPoint: .center, endPoint: .topTrailing)
                    
                    VStack {
                        Text("\(questions[currentQuestion].text)")
                            .frame(width: 1000, height: 100, alignment: .center)
                            .clipShape(Capsule(style: .circular))
                            .font(.largeTitle)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                        
                        HStack {
                            Text("Question: \(currentQuestion)")
                            Text("Score: \(100)")
                        }
                            
                        Spacer()
                        
                        HStack(spacing: 65) {
                            ForEach(questionRange, id: \.self) { index in

                                GameButton(action: {
                                    index == self.correctIndex ? self.correct() : self.incorrect()
                                    
                                }, text: "\(index == self.correctIndex ? self.questions[self.currentQuestion].answer :  self.generateWrongAnswer(correctIndex: self.correctIndex))")
                            }
                        }
                    }
                    // GameOver Alert - calls gameOver()
                    .alert(isPresented: $gameOverAlert) {
                        Alert(title: Text("Game Over!"), message: Text("You got \(self.questionsCorrect)/\(self.maxQuestionsAsked) questions correct!"), dismissButton: .default(Text("Play Again!")))
                    }
                }
            }
        }
    }
    
    func startGame() {
        // Generate Questions
        questions = []
        maxQuestionsAsked = Int(questionChoices[selectedIndex]) ?? 5
        
        for i in 1...maxQuestionsAsked {
            questions.append(Question(text: "\(tableToUse) X \(i)", answer: i * tableToUse))
        }
        questions.shuffle()
        
        // Start Game
        askQuestion()
        inSettings = false
    }
    
    func askQuestion() {
        if questions.count-1 == currentQuestion {
            gameOver()
            return
        }
        
        correctIndex = Int.random(in: questionRange)
        currentQuestion += 1
    }
    
    func correct() {
        print("correct")
        questionsCorrect += 1
        askQuestion()
    }
    
    func incorrect() {
        print("incorrect")
    }
    
    func gameOver() {
        print("game over!")
        
        currentQuestion = -1
        self.inSettings = true
    }
    
    func generateWrongAnswer(correctIndex: Int) -> Int {
        let correctAnswer = self.questions[self.currentQuestion].answer
        var wrongAnswer = self.questions[Int.random(in: 0...self.questionChoices.count)].answer
        
        // Make sure we are generating a non-duplicate wrong answer
        while wrongAnswer == correctAnswer {
            wrongAnswer = self.questions[Int.random(in: 0...self.questionChoices.count)].answer
        }
        
        return wrongAnswer
    }
}

// MARK: Views
struct GameButton: View {
    var action: () -> ()
    var text: String
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Text("\(text)")
        }
        .padding(10.0)
        .background(Color.blue)
        .foregroundColor(Color.white)
        .clipShape(Capsule(style: .circular))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

