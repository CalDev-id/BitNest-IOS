//
//  ContentView.swift
//  BitNest
//
//  Created by Heical Chandra on 14/04/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context

    @Query var crypto: [CryptoModel]
    @Query var transaction: [TransactionModel]
    @ObservedObject var transactionViewModel: TransactionViewModel
    var body: some View {
        ScrollView{
                LazyVStack{
                    HStack{
                        Group{
                            Image(systemName: "line.3.horizontal").padding(10).padding(.vertical, 5)
                        }.overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.white.opacity(0.5), lineWidth: 2)
                        )
                        Spacer()
                        Group{
                            Image(systemName: "bell").padding(10)
                        }.overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.white.opacity(0.5), lineWidth: 2)
                        )
                    }
                    Group{
                        HStack{
                            VStack(alignment: .leading){
                                Text("Total Balance")
                                Text("$510,44132").bold().padding(.vertical, 1).font(.system(size: 26))
                                Text("+$7.112(12.9%)").foregroundColor(.green).font(.system(size: 16))
                            }
                            Spacer()
                            Text("USD >").padding(10).padding(.horizontal, 10).background(.blueAsset2).cornerRadius(20).fontWeight(.semibold).font(.system(size: 16)).opacity(0.8)
                        }
                    }.padding(.top, 10)
                    HStack{
                        VStack{
                            Group{
                                Image(systemName: "square.and.arrow.up").resizable().frame(width: 30, height: 35).fontWeight(.semibold).opacity(0.8)
                            }.frame(width: 60, height: 60).background(.blueAsset2).cornerRadius(.infinity)
                            Text("Send")
                        }
                        Spacer()
                        VStack{
                            Group{
                                Image(systemName: "square.and.arrow.down").resizable().frame(width: 30, height: 35).fontWeight(.semibold).opacity(0.8)
                            }.frame(width: 60, height: 60).background(.blueAsset2).cornerRadius(.infinity)
                            Text("Receive")
                        }
                        Spacer()
                        VStack{
                            Group{
                                Image(systemName: "qrcode.viewfinder").resizable().frame(width: 30, height: 30).fontWeight(.semibold).opacity(0.8)
                            }.frame(width: 60, height: 60).background(.blueAsset2).cornerRadius(.infinity)
                            Text("Scan QR")
                        }
                        Spacer()
                        VStack{
                            Group{
                                Image(systemName: "ellipsis").resizable().frame(width: 30, height: 8).fontWeight(.semibold).opacity(0.8)
                            }.frame(width: 60, height: 60).background(.blueAsset2).cornerRadius(.infinity)
                            Text("More")
                        }
                    }.font(.system(size: 14)).padding(.vertical, 10)
                    HStack{
                        Text("Top Movers").font(.system(size: 19)).fontWeight(.semibold)
                        Spacer()
                        Text("View all").font(.system(size: 15))
                    }.padding(.vertical, 5)
                }.padding(.horizontal, 24).padding(.top, 70)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(crypto) { coin in
                            VStack(alignment: .leading){
                                HStack{
                                    Image(coin.image).resizable().frame(width: 50, height: 50, alignment: .center)
                                    VStack(alignment: .leading){
                                        Text(coin.nickName)
                                        Text(coin.name).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/).font(.system(size: 16))
                                    }
                                }
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(String("$\(coin.price)"))
                                        Text(String("\(coin.nickName == "BNB" ? "-" : "+")\(coin.growth)%")).foregroundColor(coin.nickName == "BNB" ? .red : .green)
                                    }
                                    Spacer().frame(width: 50)
                                    //linechart
//                                    let data: [Double] = [50, 100, 80, 120, 150, 200, 170, 140, 190, 220]
                                    let data: [Double] = [220, 190, 140, 170, 200, 150, 120, 80, 100, 50]
                                    let data2: [Double] = [120, 100, 80, 120, 150, 200, 170, 140, 190, 170]
                                    LineChartView(data: (coin.nickName == "BNB" ? data2 : data), lineColor: (coin.nickName == "BNB" ? .red : .green), lineWidth: 2)
                                        .frame(width: 50, height: 50)
                                }
                            }.padding().background(.blueAsset2).cornerRadius(20).onTapGesture {
                                let newTransaction = TransactionModel(price: coin.price, name: coin.name)
                                context.insert(newTransaction)
                            }
                        }
                    }
                }.padding(.leading, 24)
                VStack{
                    HStack{
                        Text("Assets").font(.system(size: 19)).fontWeight(.semibold)
                        Spacer()
                        Text("View all").font(.system(size: 15))
                    }.padding(.vertical, 5)
                    ForEach(crypto) { coin in
                        HStack{
                            Image(coin.image).resizable().frame(width: 50, height: 50, alignment: .center)
                            HStack{
                                VStack(alignment: .leading){
                                    Text(coin.name)
                                    Text(coin.nickName).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/).font(.system(size: 16))
                                }
                                Spacer()
                                let data: [Double] = [140, 170, 140, 170, 160, 150, 120, 80, 100, 50]
                                let data2: [Double] = [120, 100, 80, 120, 150, 200, 170, 140, 190, 170]
                                LineChartView(data: (coin.nickName == "BNB" ? data2 : data), lineColor: (coin.nickName == "BNB" ? .red : .green), lineWidth: 2)
                                    .frame(width: 30, height: 30)
                                Spacer()
                                VStack(alignment: .trailing){
                                    Text(String("$\(coin.price)"))
                                    Text(String("\(coin.nickName == "BNB" ? "-" : "+")\(coin.growth)%")).foregroundColor(coin.nickName == "BNB" ? .red : .green)
                                }
                            }
                        }.onTapGesture {
                            let newTransaction = TransactionModel(price: coin.price, name: coin.name)
                            context.insert(newTransaction)
                        }
                    }
                    
                    //transaction
                    if transaction.isEmpty {
                        Text("No Transaction History")
                    } else {
                        ForEach(transaction) { trans in
        //                    DeckListView(decksItem: deck, recipesItem: recipes)
                            Text("membeli : \(trans.name): $\(trans.price)").onTapGesture {
                                context.delete(trans)
                            }
                        }
                    }
                    
                }.padding(.horizontal, 24)
            
        }.padding(.bottom, 100).background(.blueAsset1).foregroundColor(.white).ignoresSafeArea()
    }
}

//#Preview {
//    ContentView(transactionViewModel: TransactionViewModel())
//}

struct LineChartView: View {
    let data: [Double]
    let lineColor: Color
    let lineWidth: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let scale = Double(geometry.size.height) / (data.max() ?? 1)
                
                for i in 0..<data.count {
                    let x = geometry.size.width / CGFloat(data.count - 1) * CGFloat(i)
                    let y = CGFloat(data[i]) * CGFloat(scale)
                    
                    if i == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
            }
            .stroke(lineColor, lineWidth: lineWidth)
        }
    }
}
