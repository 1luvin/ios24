//
//  FetchedCategory.swift
//  app
//

import Foundation

struct FetchedCategory : Codable {
    let id: Int64
    let title: String
    
    enum CodingKeys : String, CodingKey {
        case id
        case title
    }
}
