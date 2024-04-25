//
//  CustomTabBar.swift
//  BitNest
//
//  Created by Heical Chandra on 17/04/24.
//


import SwiftUI

enum Tab: String, CaseIterable {
    case house
    case creditcard
    case doc
    case person
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    private var tabColor: Color {
        switch selectedTab {
        case .house:
            return .greenAsset
        case .creditcard:
            return .greenAsset
        case .doc:
            return .greenAsset
        case .person:
            return .greenAsset
        }
    }
    
    private var tabName: String {
        switch selectedTab {
        case .house:
            return "Home"
        case .creditcard:
            return "Message"
        case .doc:
            return "Bookmark"
        case .person:
            return "Profile"
        }
    }
    
    private var tabImage: String {
        switch selectedTab {
        case .house:
            return "home"
        case .creditcard:
            return "chart"
        case .doc:
            return "saveoff"
        case .person:
            return "profileoff"
        }
    }
    
    private var tabImageOff: String {
        switch selectedTab {
        case .house:
            return "homeoff"
        case .creditcard:
            return "chartoff"
        case .doc:
            return "saveoff"
        case .person:
            return "profileoff"
        }
    }

    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    VStack{
                        Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                            .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                            .foregroundColor(tab == selectedTab ? tabColor : .gray)
                            .font(.system(size: 20))
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.1)) {
                                    selectedTab = tab
                                }
                            }
//                        Text(tabName).foregroundColor(.white).bold()
                        if (selectedTab == tab){
                            Text(tabName).foregroundColor(.greenAsset).padding(.vertical,  2)
                        }
                    }.padding(10)
                    Spacer()
                }
            }
            .padding(.top, 25)
            .frame(width: nil, height: 50)
            .background(.blueAsset2)
        }
    
    }
}

//#Preview {
//    CustomTabBar(selectedTab: .constant(.house)).background(.blue)
//}
