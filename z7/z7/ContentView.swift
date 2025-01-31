//
//  ContentView.swift
//  z7
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NotesViewModel()
    @State private var newNoteText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter note", text: $newNoteText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Add Note") {
                    guard !newNoteText.isEmpty else { return }
                    viewModel.addNote(newNoteText)
                    newNoteText = ""
                }
                .padding()
                
                Button("Clear All") {
                    viewModel.removeAllNotes()
                }
                .padding()
                
                List {
                    ForEach(viewModel.notes.indices, id: \..self) { index in
                        HStack {
                            Text(viewModel.notes[index].text)
                            Spacer()
                            Button("Delete") {
                                viewModel.removeNote(at: index)
                            }
                            .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Notes")
        }
    }
}
