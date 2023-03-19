//
//  BeerView.swift
//  lab5
//
//  Created by gurpreet on 3/6/23.
//

import SwiftUI

struct Beer: Decodable {
    let id: Int
    let name: String
    let first_brewed: String
}

struct BeerView: View {
    @State private var beers = [Beer]()
    
    var body: some View {
        NavigationView {
            List(beers, id: \.id) { b in
                VStack (alignment: .leading) {
                    Text(String(b.id))
                        .font(.headline)
                        .foregroundColor(.cyan)
                    Text(b.name)
                        .font(.body)
                        .foregroundColor(.indigo)
                    Text(b.first_brewed)
                        .font(.body)
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Beers")
            .task {
                await fetchBeerData()
            }
        }
    }
    func fetchBeerData() async {
        //create the URL
        guard let url = URL(string: "https://api.punkapi.com/v2/beers") else {
            print("URL doesn't work!")
            return
        }
        //fetch the data
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            //decode this data
            if let decodedResponse = try? JSONDecoder().decode([Beer].self, from: data) {
                beers = decodedResponse
            }
        } catch {
            print("Bad... this data is not valid")
        }
        //encode the data
        
        
    }
}

    
    

struct BeerView_Previews: PreviewProvider {
    static var previews: some View {
        BeerView()
    }
}
