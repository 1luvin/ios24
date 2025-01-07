//
//  ContentViewModel.swift
//  app
//

import Foundation
import CoreData

class ContentViewModel: ObservableObject {
    private let networkManager = NetworkManager.shared
    
    private let viewContext: NSManagedObjectContext
    
    @Published var categories: [Category]?
    @Published var productsInCategory: [Product]?
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    func getCategories() {
        guard let fetchedCategories = networkManager.fetchedCategories else { return }
        categories = fetchedCategories.map {
            let category = Category(context: viewContext)
            category.id = $0.id
            category.title = $0.title
            category.products = NSSet()
            return category
        }
        try? viewContext.save()
    }
    
    func getProducts(for category: Category) {
        guard let fetchedProducts = networkManager.fetchedProducts else { return }
        let categorizedProducts = fetchedProducts.filter { $0.categoryId == category.id }
        var products: [Product] = []
        categorizedProducts.forEach { p in
            let product = Product(context: viewContext)
            product.id = p.id
            product.title = p.title
            product.desc = p.desc
            product.price = p.price
            
            product.category = category
            category.products?.adding(product)
            
            products.append(product)
        }
        try? viewContext.save()
        
        productsInCategory = products
    }
}
