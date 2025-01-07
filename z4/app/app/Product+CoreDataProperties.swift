//
//  Product+CoreDataProperties.swift
//  app
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var price: Float
    @NSManaged public var category: Category?

}

extension Product : Identifiable {

}
