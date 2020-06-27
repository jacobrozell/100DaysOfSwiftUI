//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Jacob Rozell on 6/27/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State private var results = [Result]()

    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)

                Text(item.collectionName)
            }
        }
        .onAppear(perform: loadData)    // API call when List appears
    }

    func loadData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }

        // Create request
        let request = URLRequest(url: url)


        // Execute request
        URLSession.shared.dataTask(with: request) { data, respsonse, error in
            if let data = data {
                if let decodedResposne = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = decodedResposne.results
                    }

                    // Completed Successfully
                    return
                }
            }

            print("Fetch failed \(String(describing: error?.localizedDescription))")
        }.resume()  // Must remember to include `.resume()` or it will do nothing
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
