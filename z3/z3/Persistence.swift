//
//  Persistence.swift
//  z3
//

import CoreData

struct PersistenceController {
    static let shared: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<3 {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
            let category = Category(context: viewContext)
            category.id = UUID()
            category.title = "Category \(i + 1)"
            
            let count = Int.random(in: 2...4)
            for j in 0..<count {
                let product = Product(context: viewContext)
                product.id = UUID()
                product.title = "Product \(j + 1)"
                product.desc = "Description \(j + 1)"
                product.price = Float.random(in: 1...10)
                product.category = category
            }
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<2 {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
            let category = Category(context: viewContext)
            category.id = UUID()
            category.title = "Category \(i + 1)"
            
            for j in 0..<2 {
                let product = Product(context: viewContext)
                product.id = UUID()
                product.title = "Product \(j + 1)"
                product.desc = "Description \(j + 1)"
                product.price = Float.random(in: 1...10)
                product.category = category
            }
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "z3")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
