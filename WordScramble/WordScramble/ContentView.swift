//
//  ContentView.swift
//  WordScramble
//
//  Created by Jacob Rozell on 3/18/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var startArray: [String] = []
    @State private var startWord = ""
    
    var body: some View {
//        let word = "swift"
//        let checker = UITextChecker()
//        let range = NSRange(location: 0, length: word.utf16.count)
//        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
//

        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                startArray = fileContents.components(separatedBy: "\n")
                if let letter = startArray.randomElement() {
                    startWord = letter.trimmingCharacters(in: .whitespacesAndNewlines)
                }
            } else {
                // we no have file :(
                print("uh-oh")
            }
        }
        
        return Text("Hello")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
