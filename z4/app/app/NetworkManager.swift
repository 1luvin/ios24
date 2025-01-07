//
//  NetworkManager.swift
//  app
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseUrl = "https://014a-195-150-224-73.ngrok-free.app"
    
    var fetchedCategories: [FetchedCategory]?
    var fetchedProducts: [FetchedProduct]?
    
    func fetchCategories() async throws {
        let url = URL(string: "\(baseUrl)/categories")!
        let (data, _) = try await URLSession.shared.data(from: url)
        fetchedCategories = try JSONDecoder().decode([FetchedCategory].self, from: data)
    }
    
    func fetchProducts() async throws {
        let url = URL(string: "\(baseUrl)/products")!
        let (data, _) = try await URLSession.shared.data(from: url)
        fetchedProducts = try JSONDecoder().decode([FetchedProduct].self, from: data)
    }
}
