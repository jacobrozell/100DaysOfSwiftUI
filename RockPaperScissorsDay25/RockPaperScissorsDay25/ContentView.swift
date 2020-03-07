//
//  ContentView.swift
//  RockPaperScissorsDay25
//
//  Created by Jacob Rozell on 3/7/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

//.alert(isPresented: self.$showFinalAlert) {
//    Alert(title: Text("You \(self.finalResult)!"), dismissButton: .default(Text("Play Again")))
//}

import SwiftUI

enum RPS: String {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"
}

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
    @State private var currentChoice: RPS = .rock
    @State private var shouldWin = Bool.random()
    @State private var showAlert = false
    @State private var showFinalAlert = false
    @State private var score = 0
    @State private var roundNum = 1
    @State private var resultString = "incorrect"
    @State private var finalResult = "lost"
    @State private var randomIndex = Int.random(in: 0 ..< 3)
    
    let choices = [RPS.rock, RPS.paper, RPS.scissors]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .leading, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 35) {
                
                HStack {
                    TitleView(text: "Round: \(roundNum)/10")
                    Spacer()
                    TitleView(text: "Score: \(score)")
                }
                
                TitleView(text: "Computer chose:")
                TitleView(text: "\(choices[randomIndex].rawValue)")
                
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
                            TitleView(text: "\(choice.rawValue.capitalized)")
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
                if self.roundNum == 10 {
                    if (6...10).contains(self.score) {
                        self.finalResult = "won"
                    } else {
                        self.finalResult = "lost"
                    }
                    self.newRound(startOver: true)
                    
                } else {
                    self.newRound(startOver: false)
                }
                })
        }
    }
    
    func calcIfWin() -> Bool {
        let compChoice = choices[randomIndex]
        let winningChoice: RPS
        let losingChoice: RPS
        
        switch compChoice {
        case .rock:
            winningChoice = .paper
            losingChoice = .scissors
        case .paper:
            winningChoice = .scissors
            losingChoice = .rock
        case .scissors:
            winningChoice = .rock
            losingChoice = .paper
        }
        
        if shouldWin {
            return currentChoice == winningChoice
        } else {
            return currentChoice == losingChoice
        }
    }
    
    func checkIfCorrect() {
        let didWin = calcIfWin()
        showAlert = true
        
        if didWin {
            score += 1
            resultString = "correct"
        } else {
            resultString = "incorrect"
        }
    }
    
    func newRound(startOver: Bool) {
        showFinalAlert = startOver
        score = startOver ? 0 : score
        roundNum = startOver ? 1 : roundNum + 1
        shouldWin = Bool.random()
        randomIndex = Int.random(in: 0 ..< 3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
