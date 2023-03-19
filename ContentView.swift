//
//  ContentView.swift
//  lab5
//
//  Created by gurpreet on 3/5/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            //1.) JSON URL
            NavigationLink(destination: CurrencyView()) {
                Text("World Currency Abbreviations")
                    .font(.title3)
                    .padding(.bottom, 15)
            }
            //2.)
            NavigationLink(destination: TodosView()) {
                Text("To Do List")
                    .font(.title3)
                    .padding(.bottom, 15)
            }
            NavigationLink(destination: CoinView()) {
                Text("Coins")
                    .font(.title3)
                    .padding(.bottom, 15)
            }
            NavigationLink(destination: WikiView()) {
                Text("Wikis")
                    .font(.title3)
                    .padding(.bottom, 15)
            }
            NavigationLink(destination: BeerView()) {
                Text("Beers")
                    .font(.title3)
                    .padding(.bottom, 15)
            }
            NavigationLink(destination: FilesForAdventuresOfTom()) {
                Text("Files for Tom Sawyer Book")
                    .font(.title3)
                    .padding(.bottom, 15)
            }
        }//end of vstack
        .navigationTitle("JSON SAMPLE URLS")
        
    }//end of body
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
