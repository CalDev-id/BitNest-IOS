//
//  CryptoJSONDecoder.swift
//  BitNest
//
//  Created by Heical Chandra on 14/04/24.
//

import Foundation
import SwiftData

struct CryptoResponse: Codable {
    let name: String
    let nickName: String
    let price: Int
    let growth: Double
    let image: String
}

struct CryptoJSONDecoder {
    static func decode(from fileName: String) -> [CryptoResponse] {
        // Log: Start decoding process
        print("Decoding from file:", fileName)

        // Attempt to create URL for the JSON file
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            // Log: Unable to find file
            print("Error: Unable to find JSON file named", fileName)
            return []
        }
        // Log: URL created successfully
        print("URL for JSON file:", url)

        // Attempt to load data from the URL
        do {
            let data = try Data(contentsOf: url)
            // Log: Data loaded successfully
            print("Data loaded successfully")

            // Attempt to decode JSON data into array of RecipesResponse
            do {
                let recipes = try JSONDecoder().decode([CryptoResponse].self, from: data)
                // Log: Decoding successful
                print("Decoding successful")
                return recipes
            } catch {
                // Log: Decoding error
                print("Error decoding JSON:", error)
                return []
            }
        } catch {
            // Log: Unable to load data from URL
            print("Error loading data from URL:", error)
            return []
        }
    }
}
