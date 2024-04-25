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
    @StateObject var transactionViewModel = TransactionViewModel()
    
//    let cryptoapimodel: CryptoAPIModel

    
    init() {
        let schema = Schema([CryptoModel.self, TransactionModel.self])
         do {
             container = try ModelContainer(for: schema)
         } catch {
             fatalError("Could not configure the container")
         }
        
        cryptoViewModel = CryptoViewModel(modelContext: container.mainContext)
        cryptoViewModel.preloadCrypto()
        
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
        
//        await printData()

     }

    
    var body: some Scene {
        WindowGroup {
            NavigationView{
//                ContentView(transactionViewModel: transactionViewModel)
                MainView()
////                APIFetch()//anime
//                CameraView()
            }
        }
        .modelContainer(container)
    }
}
