//
//  WikiView.swift
//  lab5
//
//  Created by gurpreet on 3/6/23.
//

import SwiftUI

struct Wiki: Decodable {
    let timestamp: String
    let views: Int
}

struct WikiList: Decodable {
    let items: [Wiki]
}

struct WikiView: View {
    @State private var wikis = [Wiki]()
    
    var body: some View {
        
        NavigationView {
            List(wikis, id: \.timestamp) { w in
                VStack (alignment: .leading) {
                    Text(w.timestamp)
                        .font(.headline)
                        .foregroundColor(.cyan)
                    Text(String(w.views))
                        .font(.body)
                        .foregroundColor(.indigo)
                    }
            }
            
            .navigationTitle("Wikis")
            .task {
                await fetchWikiData()
            }
        }
        
        
    }
    
    func fetchWikiData() async {
        //create the URL
        guard let url = URL(string: "https://wikimedia.org/api/rest_v1/metrics/pageviews/per-article/en.wikipedia/all-access/all-agents/Tiger_King/daily/20210901/20210930") else {
            print("URL doesn't work!")
            return
        }
        //fetch the data
        do {
            let (items, _) = try await URLSession.shared.data(from: url)
            //decode this data
            if let decodedResponse = try? JSONDecoder().decode(WikiList.self, from: items) {
                wikis = decodedResponse.items
            }
        } catch {
            print("Bad... this data is not valid")
        }
        //encode the data
        
        
    }
}

struct WikiView_Previews: PreviewProvider {
    static var previews: some View {
        WikiView()
    }
}
