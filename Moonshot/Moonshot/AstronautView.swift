//
//  AstronautView.swift
//  Moonshot
//
//  Created by Jacob Rozell on 6/17/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let allMissions: [Mission] = Bundle.main.decode("missions.json")

    let astronaut: Astronaut
    let pastMissions: [Mission]

    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)

                    Text(self.astronaut.description)
                        .padding()

                    Text("Missions")
                        .padding()
                        .font(.headline)
                        .frame(alignment: .leading)

                    ForEach(self.pastMissions, id: \.id) { mission in
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Capsule())

                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                    .font(.headline)

                                Text(mission.formattedLaunchDate)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()
                        }
                        .padding(.horizontal)
                    }

                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }

    init(astronaut: Astronaut) {
        self.astronaut = astronaut

        var pastMissions = [Mission]()

        for mission in allMissions {
            for member in mission.crew {
                if member.name == self.astronaut.id {
                    pastMissions.append(mission)
                }
            }
        }
        self.pastMissions = pastMissions
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
