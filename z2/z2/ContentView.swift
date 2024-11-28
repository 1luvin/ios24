//
//  ContentView.swift
//  z2
//

import SwiftUI

struct ContentView: View {
    
    @State private var items: [TodoItem] = [
        TodoItem(
            image: "trash.fill",
            title: "Trash task"
        ),
        TodoItem(
            image: "trash.fill",
            title: "Trash task 2",
            description: "Trash description 2",
            isCompleted: true
        ),
        TodoItem(
            image: "trash.fill",
            title: "Trash task 3",
            description: "Trash description 3",
            isCompleted: false
        ),
    ]
    
    var body: some View {
        NavigationStack {
            List($items) { $item in
                HStack {
                    Image(systemName: item.image)
                    VStack(alignment: .leading) {
                        Text(item.title)
                        if let description = item.description {
                            Text(description)
                                .font(.footnote)
                        }
                    }
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                        .opacity(item.isCompleted ? 1 : 0)
                        .scaleEffect(item.isCompleted ? 1 : 0)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        item.isCompleted.toggle()
                    }
                }
                .swipeActions {
                    Button(role: .destructive) {
                        deleteItem(item)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                
            }
            .navigationTitle("Todo List")
        }
    }
    
    private func deleteItem(_ item: TodoItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
    }
}

#Preview {
    ContentView()
}
