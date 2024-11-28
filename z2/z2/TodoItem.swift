//
//  TodoItem.swift
//  z2
//

import Foundation

struct TodoItem: Identifiable {
    var id: UUID = .init()
    var image: String
    var title: String
    var description: String?
    var isCompleted: Bool = false
}
