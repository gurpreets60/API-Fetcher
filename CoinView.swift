//
//  CoinView.swift
//  lab5
//
//  Created by gurpreet on 3/5/23.
//

import SwiftUI

struct Coin: Decodable {
    let id: Int
    let lat: Double
    let lon: Double
    let name: String
}

struct CoinList: Decodable {
    let venues: [Coin]
}

struct CoinView: View {
    @State private var coins = [Coin]()
    
    var body: some View {
        NavigationView {
            List(coins, id: \.id) { c in
                VStack (alignment: .leading) {
                    Text(String(c.id))
                        .font(.headline)
                        .foregroundColor(.cyan)
                    Text(String(c.lat))
                        .font(.body)
                        .foregroundColor(.indigo)
                    Text(String(c.lon))
                        .font(.body)
                        .foregroundColor(.red)
                    Text(c.name)
                        .font(.body)
                        .foregroundColor(.cyan)
                }
            }
            .navigationTitle("Coin Map")
            .task {
                await fetchCoinData()
            }
        }
    }
    func fetchCoinData() async {
        //create the URL
        guard let url = URL(string: "https://coinmap.org/api/v1/venues/") else {
            print("URL doesn't work!")
            return
        }
        //fetch the data
        do {
            let (venues, _) = try await URLSession.shared.data(from: url)
            //decode this data
            if let decodedResponse = try? JSONDecoder().decode(CoinList.self, from: venues) {
                coins = decodedResponse.venues
            }
        } catch {
            print("Bad... this data is not valid")
        }
        //encode the data
        
        
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        CoinView()
    }
}
