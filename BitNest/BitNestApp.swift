//
//  BitNestApp.swift
//  BitNest
//
//  Created by Heical Chandra on 14/04/24.
//

import SwiftUI
import SwiftData


@main
struct BitNestApp: App {
    
    let container: ModelContainer
    let cryptoViewModel: CryptoViewModel
    
    init() {
        let schema = Schema([CryptoModel.self/*, DeckModel.self*/])
         do {
             container = try ModelContainer(for: schema)
         } catch {
             fatalError("Could not configure the container")
         }
        
        cryptoViewModel = CryptoViewModel(modelContext: container.mainContext)
        cryptoViewModel.preloadCrypto()
        
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
     }

    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .modelContainer(container)
    }
}
