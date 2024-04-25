//
//  APIFetch.swift
//  BitNest
//
//  Created by Heical Chandra on 22/04/24.
//

import SwiftUI
import Foundation

struct APIFetch: View {
    @State private var topAnime: [AnimeData] = []
    
    var body: some View {
        NavigationView {
            VStack {
                if topAnime.isEmpty {
                    Text("Loading...")
                } else {
                    List(topAnime, id: \.mal_id) { anime in
                        VStack {
                            Text("Title: \(anime.title)")
                            Text("Type: \(anime.type)")
                            Text("Status: \(anime.status)")
                            Text("Score: \(anime.score!)")
                        }
                    }
                }
            }
            .navigationTitle("Top Anime")
            .task {
                await fetchData()
            }
        }
    }
    
    func fetchData() async {
        guard let url = URL(string: "https://api.jikan.moe/v4/top/anime") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(AnimeResponse.self, from: data)
            topAnime = response.data
        } catch {
            print("Error fetching data: \(error)")
        }
    }
}

//struct AnimeResponse: Codable {
//    let pagination: Pagination
//    let data: [AnimeData]
//}

struct Pagination: Codable {
    let last_visible_page: Int
    let has_next_page: Bool
    let current_page: Int
    let items: PaginationItems
}

struct PaginationItems: Codable {
    let count: Int
    let total: Int
    let per_page: Int
}

struct AnimeResponse: Codable {
    let pagination: Pagination
    let data: [AnimeData]
}

struct AnimeData: Codable {
    let mal_id: Int
    let url: String
    let images: AnimeImages
    let trailer: Trailer?
    let approved: Bool
    let titles: [Title]
    let title: String
    let title_english: String?
    let title_japanese: String?
    let title_synonyms: [String]?
    let type: String
    let source: String
    let episodes: Int
    let status: String
    let airing: Bool
    let aired: Aired
    let duration: String?
    let rating: String?
    let score: Double?
    let scored_by: Int?
    let rank: Int?
    let popularity: Int?
    let members: Int?
    let favorites: Int?
    let synopsis: String?
    let background: String?
    let season: String?
    let year: Int?
    let broadcast: Broadcast
    let producers: [Producer]
    let licensors: [Licensors]
    let studios: [Studio]
    let genres: [Genre]
    let explicit_genres: [String]
    let themes: [Themes]
    let demographics: [Demographic]
}

struct Themes: Codable {
    let mal_id: Int
    let type: String
    let name: String
    let url: String
}
struct Licensors: Codable {
    let mal_id: Int
    let type: String
    let name: String
    let url: String
}

struct AnimeImages: Codable {
    let jpg: ImageURLs
    let webp: ImageURLs
}

struct ImageURLs: Codable {
    let image_url: String?
    let small_image_url: String?
    let large_image_url: String?
}

struct Trailer: Codable {
    let youtube_id: String?
    let url: String?
    let embed_url: String?
    let images: TrailerImages?
}

struct TrailerImages: Codable {
    let image_url: String?
    let small_image_url: String?
    let medium_image_url: String?
    let large_image_url: String?
    let maximum_image_url: String?
}

struct Title: Codable {
    let type: String
    let title: String
}

struct Aired: Codable {
    let from: String?
    let to: String?
    let prop: AiredProp
    let string: String?
}

struct AiredProp: Codable {
    let from: AiredDate?
    let to: AiredDate?
}

struct AiredDate: Codable {
    let day: Int?
    let month: Int?
    let year: Int?
}

struct Broadcast: Codable {
    let day: String?
    let time: String?
    let timezone: String?
    let string: String?
}

struct Producer: Codable {
    let mal_id: Int
    let type: String
    let name: String
    let url: String
}

struct Studio: Codable {
    let mal_id: Int
    let type: String
    let name: String
    let url: String
}

struct Genre: Codable {
    let mal_id: Int
    let type: String
    let name: String
    let url: String
}

struct Demographic: Codable {
    let mal_id: Int
    let type: String
    let name: String
    let url: String
}
