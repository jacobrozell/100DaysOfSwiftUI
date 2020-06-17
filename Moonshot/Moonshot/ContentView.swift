//
//  ContentView.swift
//  Moonshot
//
//  Created by Jacob Rozell on 6/17/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State private var showingLaunch = true
    @State private var names = []

    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission, self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(self.showingLaunch == true ? mission.formattedLaunchDate : self.getNameFromIds(mission.crewIds))
                    }

                }
            }
        .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(self.showingLaunch == true ? "Show Astronauts" : "Show Launch Date") {
                self.showingLaunch.toggle()
            })
        }
    }

    func getNameFromIds(_ crewIds: [String]) -> String {
        var payload = ""
        for id in crewIds {
            if let name = astronauts.first(where: { $0.id == id })?.name {
                payload += "\(name)\n"
            }
        }
        return payload
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
