//
//  clientApp.swift
//  client
//

import SwiftUI
import OAuthSwift

@main
struct clientApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    OAuthSwift.handle(url: url)
                }
        }
    }
}
