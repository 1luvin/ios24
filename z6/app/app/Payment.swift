//
//  Payment.swift
//  app
//

import Foundation

struct Payment: Codable, Identifiable {
    var id: Int
    var productName: String
    var amount: Float
    var status: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case productName = "product_name"
        case amount = "amount"
        case status = "status"
    }
}
