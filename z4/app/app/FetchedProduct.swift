//
//  FetchedProduct.swift
//  app
//

import Foundation

struct FetchedProduct : Codable {
    let id: Int64
    let title: String
    let desc: String
    let price: Float
    let categoryId: Int64
    
    enum CodingKeys : String, CodingKey {
        case id
        case title
        case desc
        case price
        case categoryId = "category_id"
    }
}
