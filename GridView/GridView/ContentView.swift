//
//  ContentView.swift
//  GridView
//
//  Created by Jacob Rozell on 6/23/20.
//  Copyright © 2020 jacobrozell. All rights reserved.
//

import QGrid
import SwiftUI

// MARK: Model
struct Person: Codable, Identifiable {
    var id: Int
    var firstName: String
    var lastName: String
    var imageName: String
}

// MARK: GridCell
struct GridCell: View {
  var person: Person

  var body: some View {
    VStack() {
      Image(person.imageName)
        .resizable()
        //.frame(width: 100, height: 100)
        .scaledToFit()

      Text(person.firstName).lineLimit(1)
      Text(person.lastName).lineLimit(1)
    }
    .font(.headline)
    .foregroundColor(.white)
  }
}


struct PeopleView: View {
    var people: [Person] = [
        Person(id: 0,
               firstName: "Jacob",
               lastName: "Rozell",
               imageName: "jacob"),
        Person(id: 1,
               firstName: "Logan",
               lastName: "Howell",
               imageName: "logan"),
        Person(id: 2,
               firstName: "Josh",
               lastName: "Carter",
               imageName: "josh"),
        Person(id: 3,
               firstName: "Jacob",
               lastName: "Rozell",
               imageName: "jacob"),
        Person(id: 4,
               firstName: "Logan",
               lastName: "Howell",
               imageName: "logan"),
        Person(id: 5,
               firstName: "Josh",
               lastName: "Carter",
               imageName: "josh")
    ]

    var body: some View {
        QGrid(people,
              columns: 20,
              columnsInLandscape: 69,
              vSpacing: 10,
              hSpacing: 10,
              vPadding: 0,
              hPadding: 10,
              isScrollable: true,
              showScrollIndicators: true)
        {
            GridCell(person: $0)
        }
    }
}

struct ContentView: View {
    var body: some View {
        PeopleView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
