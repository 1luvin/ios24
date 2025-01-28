//
//  ContentView.swift
//  client
//

import SwiftUI
import OAuthSwift
import GoogleSignInSwift

struct ContentView: View {
    @StateObject private var networkManager = NetworkManager()
    
    @State private var username = ""
    @State private var password = ""
    @State private var message = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoggedIn {
                    Group {
                        Spacer()
                        
                        Text(message)
                            .foregroundColor(.gray)
                            .padding()
                        
                        Spacer()

                        Button(action: logout) {
                            Text("Sign Out")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .navigationTitle("Welcome, \(username)")
                } else {
                    TextField("Username", text: $username)
                        .textFieldStyle(.roundedBorder)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                    
                    Spacer()
                    
                    Text(message)
                        .foregroundColor(.gray)
                        .padding()
                    
                    Button(action: register) {
                        Text("Register")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    Button(action: login) {
                        Text("Sign In")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    GoogleSignInButton(action: authenticateWithGoogle)
                }
            }
            .padding()
            .navigationTitle("OAuth")
        }
    }

    func register() {
        networkManager.register(username: username, password: password) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    isLoggedIn = true
                    message = response
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    message = "Error: \(error.localizedDescription)"
                }
            }
        }
    }

    func login() {
        networkManager.login(username: username, password: password) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    isLoggedIn = true
                    message = "Signed In!"
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    message = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func authenticateWithGoogle() {
        let oauth2 = OAuth2Swift(
            consumerKey: "739530272416-jlieuvc6irerbk9ha7bhpgp4u8m5bj3s.apps.googleusercontent.com",
            consumerSecret: "",
            authorizeUrl: "https://accounts.google.com/o/oauth2/auth",
            accessTokenUrl: "https://oauth2.googleapis.com/token",
            responseType: "code"
        )
        
        let windowScenes = UIApplication.shared.connectedWindowScenes
        let activateScenes = windowScenes.filter { $0.activationState == .foregroundActive }
        guard let viewController = activateScenes.first?.keyWindow?.rootViewController else { return }
        
        oauth2.authorizeURLHandler = SafariURLHandler(
            viewController: viewController,
            oauthSwift: oauth2
        )
        
        oauth2.authorize(
            withCallbackURL: "luvin.client:/oauth2callback",
            scope: "profile",
            state: "GOOGLE"
        ) { result in
            switch result {
            case .success(let (credential, _, _)):
                sendOAuthTokenToServer(token: credential.oauthToken, endpoint: "oauth/google")
            case .failure(let error):
                DispatchQueue.main.async {
                    message = "Google auth failed: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func sendOAuthTokenToServer(token: String, endpoint: String) {
        guard let url = URL(string: "\(networkManager.baseURL)/\(endpoint)") else { return }
        let body: [String: Any] = ["token": token]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            if let result = try? JSONDecoder().decode([String: String].self, from: data) {
                DispatchQueue.main.async {
                    if result["message"] != nil {
                        isLoggedIn = true
                        self.message = "Signed In with Google"
                    } else if let error = result["error"] {
                        message = "Error: \(error)"
                    }
                }
            } else {
                DispatchQueue.main.async {
                    message = "Error: Could not parse response"
                }
            }
        }.resume()
    }

    func logout() {
        isLoggedIn = false
        username = ""
        password = ""
        message = "Signed Out."
    }
}

#Preview {
    ContentView()
}
