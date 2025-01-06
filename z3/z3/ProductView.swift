//
//  ProductView.swift
//  z3
//

import SwiftUI

struct ProductView: View {
    
    let product: Product
    
    var body: some View {
        VStack {
            Text(product.title!)
            Text(product.desc!)
            let price = String(format: "%.2f", product.price)
            Text("Price: \(price)$")
        }
    }
}
