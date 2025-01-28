//
//  NetworkManager.swift
//  client
//

import Foundation

class NetworkManager: ObservableObject {
    @Published var accessToken: String?

    let baseURL = "https://ba13-195-150-224-73.ngrok-free.app"

    func register(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/register") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = [
            "username": username,
            "password": password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, _ in
            if let data = data, let response = try? JSONSerialization.jsonObject(with: data) as? [String: String] {
                if let message = response["message"] {
                    completion(.success(message))
                } else if let error = response["error"] {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: error])))
                }
            }
        }.resume()
    }

    func login(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/login") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = [
            "username": username,
            "password": password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, _ in
            if let data = data, let response = try? JSONSerialization.jsonObject(with: data) as? [String: String] {
                if let token = response["access_token"] {
                    DispatchQueue.main.async {
                        self.accessToken = token
                    }
                    completion(.success(token))
                } else if let error = response["error"] {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: error])))
                }
            }
        }.resume()
    }
}
