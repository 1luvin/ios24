//
//  Category+CoreDataProperties.swift
//  app
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var products: NSSet?
    
    public var productsArray: [Product] {
        let set = products as? Set<Product> ?? []
        return set.sorted {
            $0.title! < $1.title!
        }
    }
}

// MARK: Generated accessors for products
extension Category {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: Product)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: Product)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}

extension Category : Identifiable {

}
