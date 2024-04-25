//
//  CryptoAPIModel.swift
//  BitNest
//
//  Created by Heical Chandra on 22/04/24.
//

import Foundation

//let url = URL(string: "https://api.coingecko.com/api/v3/coins/list")!
//var request = URLRequest(url: url)
//request.httpMethod = "GET"
//request.timeoutInterval = 10
//request.allHTTPHeaderFields = [
//  "accept": "application/json",
//  "x-cg-demo-api-key": "CG-khSQuAPZNEwKJv3hFetKKNYZ"
//]
//
//let (data, response) = try await URLSession.shared.data(for: request)
//print(String(decoding: data, as: UTF8.self))

func fetchData() async throws -> Data {
    let url = URL(string: "https://api.coingecko.com/api/v3/coins/list")!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.timeoutInterval = 10
    request.allHTTPHeaderFields = [
        "accept": "application/json",
        "x-cg-demo-api-key": "CG-khSQuAPZNEwKJv3hFetKKNYZ"
    ]

    let (data, _) = try await URLSession.shared.data(for: request)
    return data
}

func printData() async {
    do {
        let data = try await fetchData()
        print(String(decoding: data, as: UTF8.self))
    } catch {
        print("Error fetching data: \(error)")
    }
}

// Call the printData function asynchronously
//Task {
//    await printData()
//}
