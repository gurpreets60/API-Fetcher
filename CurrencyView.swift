//
//  CurrencyView.swift
//  lab5
//
//  Created by gurpreet on 3/5/23.
//

import SwiftUI

struct Currency: Decodable {
    let id: String
    let name: String
    let min_size: String
}

struct CurrencyList: Decodable {
    let data: [Currency]
}

struct CurrencyView: View {
    @State private var currencies = [Currency]()
    
    var body: some View {
        NavigationView {
            List(currencies, id: \.id) { c in
                VStack (alignment: .leading) {
                    Text(c.id)
                        .font(.headline)
                        .foregroundColor(.cyan)
                    Text(c.name)
                        .font(.body)
                        .foregroundColor(.indigo)
                    Text(c.min_size)
                        .font(.body)
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("World Currency")
            .task {
                await fetchCurrencyData()
            }
        }
    }
    func fetchCurrencyData() async {
        //create the URL
        guard let url = URL(string: "https://api.coinbase.com/v2/currencies") else {
            print("URL doesn't work!")
            return
        }
        //fetch the data
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            //decode this data
            if let decodedResponse = try? JSONDecoder().decode(CurrencyList.self, from: data) {
                currencies = decodedResponse.data
            }
        } catch {
            print("Bad... this data is not valid")
        }
        //encode the data
        
        
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}
