//
//  TodosView.swift
//  lab5
//
//  Created by gurpreet on 3/5/23.
//

import SwiftUI

struct Todo: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}

struct TodosView: View {
    @State private var todos = [Todo]()
    
    var body: some View {
        NavigationView {
            List(todos, id: \.id) { t in
                VStack (alignment: .leading) {
                    Text(String(t.id))
                        .font(.headline)
                        .foregroundColor(.cyan)
                    Text(t.title)
                        .font(.body)
                        .foregroundColor(.indigo)
                    Text(String(t.completed))
                        .font(.body)
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("To Do List")
            .task {
                await fetchTodoData()
            }
        }
    }
    func fetchTodoData() async {
        //create the URL
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
            print("URL doesn't work!")
            return
        }
        //fetch the data
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            //decode this data
            if let decodedResponse = try? JSONDecoder().decode([Todo].self, from: data) {
                todos = decodedResponse
            }
        } catch {
            print("Bad... this data is not valid")
        }
        //encode the data
        
        
    }
}



struct TodosView_Previews: PreviewProvider {
    static var previews: some View {
        TodosView()
    }
}
