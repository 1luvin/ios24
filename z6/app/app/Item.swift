//
//  Item.swift
//  app
//
//  Created by Alexander Zybailo on 21/01/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
