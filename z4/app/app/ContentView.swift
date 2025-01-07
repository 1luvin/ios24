//
//  ContentView.swift
//  app
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var selectedCategory: Int = 0
        
    private var networkManager: NetworkManager = NetworkManager.shared
    @StateObject private var viewModel: ContentViewModel
    
    init() {
        let context = PersistenceController.shared.container.viewContext
        _viewModel = StateObject(wrappedValue: ContentViewModel(viewContext: context))
    }
    
    var body: some View {
        NavigationView {
            if let categories = viewModel.categories {
                List(categories) { category in
                    NavigationLink {
                        Group {
                            if let products = viewModel.productsInCategory {
                                List(products) { product in
                                    NavigationLink {
                                        ProductView(product: product)
                                    } label: {
                                        Text(product.title!)
                                    }
                                }
                            } else {
                                Text("Loading...")
                            }
                        }
                        .navigationTitle(category.title!)
                        .onAppear {
                            viewModel.getProducts(for: category)
                        }
                    } label: {
                        Text(category.title!)
                    }
                }
                .navigationTitle("Categories")
            } else {
                EmptyView()
                    .navigationTitle("Loading...")
            }
        }
        .onAppear {
            Task {
                try! await networkManager.fetchCategories()
                try! await networkManager.fetchProducts()
                viewModel.getCategories()
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
