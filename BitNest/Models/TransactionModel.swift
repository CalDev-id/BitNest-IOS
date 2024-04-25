//
//  TransactionModel.swift
//  BitNest
//
//  Created by Heical Chandra on 16/04/24.
//

import Foundation
import SwiftData

@Model
class TransactionModel {
    @Attribute(.unique) var id: String
    var price: Int
    var name: String
    
    init(price: Int, name: String) {
        self.id = UUID().uuidString
        self.price = price
        self.name = name
    }
}
