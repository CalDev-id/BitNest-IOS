//
//  MainView.swift
//  BitNest
//
//  Created by Heical Chandra on 17/04/24.
//

import SwiftUI

struct MainView: View {
    @State private var tabSelected: Tab = .house
    @StateObject var transactionViewModel = TransactionViewModel()

    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
//                    Spacer()
                    TabView(selection: $tabSelected) {
                        ForEach(Tab.allCases, id: \.self) { tab in
                            getView(for: tab)
                                .tag(tab)
                        }
                    }
                }
                VStack {
                    Spacer()
                    CustomTabBar(selectedTab: $tabSelected)
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    func getView(for tab: Tab) -> some View {
        switch tab {
        case .house:
            return AnyView(ContentView(transactionViewModel: transactionViewModel))
        case .creditcard:
            return AnyView(FetchAPI())
        case .doc:
            return AnyView(ContentView(transactionViewModel: transactionViewModel))
        case .person:
            return AnyView(ContentView(transactionViewModel: transactionViewModel))
        }
    }
}

//#Preview {
//    ContentViews().previewInterfaceOrientation(.portrait)
//}
