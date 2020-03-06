//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jacob Rozell on 3/4/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI
import AVFoundation

var avPlayer: AVAudioPlayer?

struct FlagImage: View {
    let imageUrl: String
    
    var body: some View {
        Image(imageUrl)
        .renderingMode(.original)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
        .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State var score = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center, spacing: 30) {
                    
                    Text("Tap the \(countries[correctAnswer]) flag!")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                    
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            self.flagTapped(number)
                        }) {
                            FlagImage(imageUrl: self.countries[number])
                        }
                    }
                    
                    Text("Current Score: \(score)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                    Spacer()
                }
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("Your score is \(score)!"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        var result = ""
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
            result = "correct"
        } else {
            scoreTitle = "Incorrect!\nThat is the flag of \(countries[number])"
            result = "incorrect"
            
        }
        
        showingScore = true
        DispatchQueue.main.async {
            self.playSound(result)
        }
    }
    
    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func playSound(_ sound: String) {
        let path = Bundle.main.path(forResource: "\(sound).mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            avPlayer = try AVAudioPlayer(contentsOf: url)
            avPlayer?.play()
        } catch {
            // couldn't load file :(
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
