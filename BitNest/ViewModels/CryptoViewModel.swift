//
//  CryptoViewModel.swift
//  BitNest
//
//  Created by Heical Chandra on 14/04/24.
//

import Foundation
import SwiftData


class CryptoViewModel: ObservableObject {
    let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func preloadCrypto() {
        //Check we haven't already added our recipes.
        let descriptor = FetchDescriptor<CryptoModel>()
        let existingRecipes = try? modelContext.fetchCount(descriptor)
        guard existingRecipes == 0 else { return }
        
        //if decode success
        let crypto = CryptoJSONDecoder.decode(from: "Crypto")
        if !crypto.isEmpty {
            crypto.forEach { item in
                let recipe = CryptoModel(
                    name: item.name,
                    nickName: item.nickName,
                    price: item.price,
                    growth: item.growth,
                    image: item.image
                )
                modelContext.insert(recipe)
            }
        }
    }
}
