//
//  NotesViewModel.swift
//  z7
//

import Foundation

class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []
    
    func addNote(_ text: String) {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }
        let newNote = Note(text: trimmedText)
        notes.append(newNote)
    }
    
    func removeNote(at index: Int) {
        guard notes.indices.contains(index) else { return }
        notes.remove(at: index)
    }
    
    func removeAllNotes() {
        notes.removeAll()
    }
    
    func noteExists(_ text: String) -> Bool {
        return notes.contains { $0.text == text }
    }
}
