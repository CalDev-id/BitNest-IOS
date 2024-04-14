//
//  ContentView.swift
//  BitNest
//
//  Created by Heical Chandra on 14/04/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var crypto: [CryptoModel]

    var body: some View {
        VStack {
            ForEach(crypto) { coin in
                Text("\(coin.name): $\(coin.value)")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
