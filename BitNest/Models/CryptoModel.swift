//
//  CryptoModel.swift
//  BitNest
//
//  Created by Heical Chandra on 14/04/24.
//

import Foundation
import SwiftData

@Model
class CryptoModel: Codable {
    
    @Attribute(.unique) var id: String
    var name: String
    var nickName: String
    var value: Int
    var growth: Double
    var image: String
    
    enum CodingKeys: CodingKey {
        case id, name, nickName, value, growth, image
    }
    
    init(name: String, nickName: String, value:Int, growth:Double, image: String) {
        self.id = UUID().uuidString
        self.name = name
        self.nickName = nickName
        self.value = value
        self.growth = growth
        self.image = image
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        self.name = try container.decode(String.self, forKey: .name)
        self.nickName = try container.decode(String.self, forKey: .nickName)
        self.value = try container.decode(Int.self, forKey: .value)
        self.growth = try container.decode(Double.self, forKey: .growth)
        self.image = try container.decode(String.self, forKey: .image)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(nickName, forKey: .nickName)
        try container.encode(value, forKey: .value)
        try container.encode(growth, forKey: .growth)
        try container.encode(image, forKey: .image)
    }
}
