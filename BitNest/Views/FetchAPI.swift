//
//  FetchAPI.swift
//  BitNest
//
//  Created by Heical Chandra on 22/04/24.
//

import SwiftUI

struct CryptoResponse1: Codable {
    let id: String
    let symbol: String
    let name: String
}
struct FetchAPI: View {
    @State private var cryptoData: [String] = []
    
    var body: some View {
        VStack {
            Text("Cryptocurrencies")
                .font(.title)
            
            if cryptoData.isEmpty {
                Text("Loading...")
            } else {
                List(cryptoData, id: \.self) { crypto in
                    Text(crypto)
                }
            }
        }
        .onAppear {
            fetchData()
        }
    }
    
    func fetchData() {
        Task {
            do {
                let data = try await fetchDataFromAPI()
                self.cryptoData = data
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
    
    func fetchDataFromAPI() async throws -> [String] {
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/list")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
            request.allHTTPHeaderFields = [
                "accept": "application/json",
                "x-cg-demo-api-key": "CG-khSQuAPZNEwKJv3hFetKKNYZ"
            ]

        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedData = try JSONDecoder().decode([CryptoResponse1].self, from: data)
        return decodedData.map { $0.name }
    }
}




//#Preview {
//    FetchAPI()
//}

