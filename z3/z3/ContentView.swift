//
//  ContentView.swift
//  z3
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.title!, ascending: true)],
        animation: .default)
    private var categories: FetchedResults<Category>

    @State private var selectedCategory: Int = 0
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Picker("Categories", selection: $selectedCategory) {
                    ForEach(0..<categories.count, id: \.self) { index in
                        Text(categories[index].title!).tag(index)
                    }
                }
                .pickerStyle(.segmented)
                
                let category = categories[selectedCategory]
                let products = category.productsArray
                
                List(products) { product in
                    NavigationLink {
                        ProductView(product: product)
                    } label: {
                        Text(product.title!)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
            .navigationTitle("Categories")
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
