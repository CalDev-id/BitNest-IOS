//
//  AnimeAPI.swift
//  BitNest
//
//  Created by Heical Chandra on 22/04/24.
//

import SwiftUI

struct AnimeAPI: Codable {
    let mal_id: Int
    let rank: Int
    let title: String
}

struct APIFetch: View {
    @State private var topAnime: [AnimeAPI] = []

    var body: some View {
        NavigationView{
            List(topAnime, id: \.mal_id){ anime in
                VStack{
                    Text(String(anime.mal_id))
                    Text(anime.title)
                }
            }
        }
    }
    
    func fetchData() async {
        guard let url = URL(string: "https://api.jikan.moe/v4/top/anime")else{
            print("sorry lil bro")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            //decode
            if let decodeResponse = try? JSONDecoder().decode([AnimeAPI].self, from:data){
                topAnime = decodeResponse
            }
        } catch {
            print("data isnt valid lil bro")
        }
    }
}

#Preview {
    AnimeAPI()
}
