//
//  Product+CoreDataProperties.swift
//  z3
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var price: Float
    @NSManaged public var title: String?
    @NSManaged public var category: Category?

}

extension Product : Identifiable {

}
