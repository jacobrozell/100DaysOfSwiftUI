//
//  ContentView.swift
//  RockPaperScissorsDay25
//
//  Created by Jacob Rozell on 3/7/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .padding(.all)
            .foregroundColor(Color.white)
            .shadow(color: .black, radius: 2)
            .font(.title)
    }
}


struct ContentView: View {
    @State private var currentChoice = ""
    @State private var shouldWin = Bool.random()
    @State private var showAlert = false
    @State private var wasCorrect = false
    @State private var score = 0
    @State private var roundNum = 0
    @State private var resultString = "incorrect"
    @State private var randomIndex = Int.random(in: 0 ..< 3)
    
    let choices = ["Rock", "Paper", "Scissors"]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .leading, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack(spacing: 35) {
                
                HStack {
                    TitleView(text: "Round: \(roundNum)")
                    Spacer()
                    TitleView(text: "Score: \(score)")
                }
                
                TitleView(text: "I have chosen \(choices[randomIndex]).")
                
                // Image of choice here
                
                               
                if shouldWin {
                    TitleView(text: "Win this round!")
                } else {
                    TitleView(text: "Lose this round!")
                }
                
                Spacer()
                HStack(spacing: 10) {
                    ForEach(choices, id: \.self) { choice in
        
                        Button(action: {
                            self.currentChoice = choice
                            self.checkIfCorrect()
                        }) {
                            //change this to images
                            TitleView(text: "\(choice)")
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.black, lineWidth: 2))
                        }
                    }
                }
                Spacer()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("You were \(resultString)!"), dismissButton: .default(Text("Next round")) {
                self.newRound()
            })
        }
    }
    
    func checkIfCorrect() {
        showAlert = true
        if (currentChoice == choices[randomIndex]) && shouldWin {
            wasCorrect = true
            score += 1
            resultString = "correct"
            return
        }
        
        if (currentChoice != choices[randomIndex]) && !shouldWin {
            wasCorrect = true
            score += 1
            resultString = "correct"
            return
            
        }

        resultString = "incorrect"
        wasCorrect = false
    }
    
    func newRound() {
        self.roundNum += 1
        shouldWin = Bool.random()
        randomIndex = Int.random(in: 0 ..< 3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
