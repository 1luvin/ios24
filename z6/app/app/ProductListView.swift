//
//  ProductListView.swift
//  app
//

import SwiftUI

struct ProductListView: View {
    let products = [
        Product(name: "Product 1", price: 10.0),
        Product(name: "Product 2", price: 20.0),
        Product(name: "Product 3", price: 30.0)
    ]
    
    var makePayment: (Payment) -> Void
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List(products) { product in
                HStack {
                    VStack(alignment: .leading) {
                        Text(product.name)
                            .font(.headline)
                        Text("Price: $\(product.price, specifier: "%.2f")")
                    }
                    
                    Spacer()
                    
                    Button("Buy") {
                        let newPayment = Payment(
                            id: Int.random(in: 1000...9999),
                            productName: product.name,
                            amount: product.price,
                            status: "pending"
                        )
                        makePayment(newPayment)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .padding()
                }
            }
            .navigationTitle("Products")
        }
    }
}
