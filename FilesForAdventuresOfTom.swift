//
//  FilesForAdventuresOfTom.swift
//  lab5
//
//  Created by gurpreet on 3/5/23.
//

import SwiftUI

struct File: Decodable {
    let name: String
    let format: String
    let size: Int
}

struct FileList: Decodable {
    let files: [File]
}


struct FilesForAdventuresOfTom: View {
    @State private var theFiles = [File]()
    
    var body: some View {
        
        NavigationView {
            List(theFiles, id: \.name) { f in
                VStack (alignment: .leading) {
                    Text(f.name)
                        .font(.body)
                        .foregroundColor(.cyan)
                    Text(f.format)
                        .font(.body)
                        .foregroundColor(.indigo)
                    Text(String(f.size))
                        .font(.body)
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Files")
            .task {
                await fetchFilesData()
            }
        }
    }
    func fetchFilesData() async {
        //create the URL
        guard let url = URL(string: "https://archive.org/metadata/TheAdventuresOfTomSawyer_201303") else {
            print("URL doesn't work!")
            return
        }
        //fetch the data
        do {
            let (files, _) = try await URLSession.shared.data(from: url)
            //decode this data
            if let decodedResponse = try? JSONDecoder().decode(FileList.self, from: files) {
                theFiles = decodedResponse.files
            }
        } catch {
            print("Bad... this data is not valid")
        }
        //encode the data
        
    }
        
}

struct FilesForAdventuresOfTom_Previews: PreviewProvider {
    static var previews: some View {
        FilesForAdventuresOfTom()
    }
}
