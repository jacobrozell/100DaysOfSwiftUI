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

    enum QuestionOption {
        case correct
        case incorrect
    }

    let questionChoices = ["5", "10", "15", "20"]
    let praises = ["Good job!", "Fantastic!", "Wonderful!", "Awesome!", "Spectacular!", "Cool!", "Wow!", "Way to go!"]
    @State private var tableToUse = 2
    @State private var selectedIndex = 0

    @State private var questions: [Question] = []
    @State private var currentQuestion = 0     // Starts at 0 in askQuestion

    @State private var makeButtons = true
    @State private var inSettings = true
    let questionRange = 1...3

    @State private var answerText = ""

    @State private var showAlert = false
    @State private var alertText = ""
    @State private var alertMessage = ""
    @State private var alertButtonText = ""
    @State private var alertState: QuestionOption = .incorrect

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
                    .padding()
            }
            else {
                VStack(spacing: 50) {
                    Section(header:
                        Text("Question: \(currentQuestion) / \(maxQuestionsAsked)")
                            .font(.largeTitle)) {
                                Text("\(questions[currentQuestion-1].text)")
                                    .font(.largeTitle)
                    }

                    HStack {
                        TextField("Answer:", text: $answerText)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()

                        GameButton(action: {
                            self.checkAnswer()
                        }, text: "Check Answer")
                            .padding()
                    }

                    Spacer()
                }.onTapGesture {
                    UIApplication.shared.endEditing()
                }

                .alert(isPresented: $showAlert) {
                    Alert(title: Text("\(alertText)"), message: Text("\(alertMessage)"), dismissButton: .default(Text("\(alertButtonText)")) {

                        switch self.alertState {
                        case .correct:
                            self.answerText = ""
                            self.askQuestion()
                        case .incorrect:
                            return
                        }
                        self.showAlert = false
                        self.makeButtons = false
                        })
                }
                .animation(.default)
            }
        }
    }

    func startGame() {
        // Generate Questions
        questions = []
        maxQuestionsAsked = Int(questionChoices[selectedIndex]) ?? 5

        for i in 1...maxQuestionsAsked+1 {
            questions.append(Question(text: "\(tableToUse) X \(i)", answer: i * tableToUse))
        }
        questions.shuffle()

        // Start Game
        askQuestion()
        inSettings = false
    }

    func checkAnswer() {
        if Int(answerText) == questions[currentQuestion-1].answer {
            print("Correct")
            alertText = "Correct"
            alertMessage = praises.randomElement() ?? "Good Job!"
            alertButtonText = "Next Question!"
            alertState = .correct

        } else {
            print("incorrect")
            alertText = "Incorrect!"
            alertMessage = "Try again?"
            alertButtonText = "Okay!"
            alertState = .incorrect
        }
        showAlert = true
    }

    func askQuestion() {
        currentQuestion += 1

        if currentQuestion >= questions.count {
            gameOver()
            return
        }
    }

    func gameOver() {
        print("game over!")

        currentQuestion = 0
        self.inSettings = true
    }
}

// MARK: - CustomViews
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

// MARK: - Extensions
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

