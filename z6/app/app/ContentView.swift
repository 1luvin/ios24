//
//  ContentView.swift
//  app
//

import SwiftUI

struct ContentView: View {
    @State private var payments: [Payment] = []
    @State private var isShowingProducts = false
    
    private let baseURL = "https://89c5-195-150-224-73.ngrok-free.app"
    
    var body: some View {
        NavigationView {
            VStack {
                List(payments) { payment in
                    VStack(alignment: .leading) {
                        Text(payment.productName)
                            .font(.headline)
                        Text("Amount: $\(payment.amount, specifier: "%.2f")")
                        Text("Status: \(payment.status)")
                            .foregroundColor(payment.status == "completed" ? .green : .red)
                    }
                }
                
                Button(action: {
                    isShowingProducts = true
                }) {
                    Text("Show Products")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .navigationTitle("Payments")
            .onAppear(perform: fetchPurchases)
            .sheet(isPresented: $isShowingProducts) {
                ProductListView(makePayment: makePayment)
            }
        }
    }
    
    func makePayment(payment: Payment) {
        guard let url = URL(string: "\(baseURL)/pay") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(payment)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.fetchPurchases()
            }
        }.resume()
    }
    
    func fetchPurchases() {
        guard let url = URL(string: "\(baseURL)/payments") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let decodedPayments = try? JSONDecoder().decode([Payment].self, from: data) {
                DispatchQueue.main.async {
                    payments = decodedPayments
                }
            }
        }.resume()
    }
}
