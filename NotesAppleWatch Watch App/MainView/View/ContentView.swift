//
//  ContentView.swift
//  NotesAppleWatch Watch App
//
//  Created by Дмитрий Пермяков on 12.08.2023.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: PROPERTY
    
    @State private var noteText = ""
    @State private var allNotes : [Note] = []
    
    // MARK: BODY
    
    var body: some View {
        VStack {
            HeaderView()
            NotesListView()
        }
        .navigationTitle("Notes")
        .onAppear(perform: FetchData)
    }
    
    // MARK: - UI FUNCTIONS
    @ViewBuilder
    private func HeaderView() -> some View {
        HStack(spacing: 6) {
            TextField("New note", text: $noteText)
            
            Button {
                didPressPlus()
                
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(noteText.isEmpty ? .gray.opacity(0.6) : .yellow)
            }
            .fixedSize()
            .disabled(noteText.isEmpty)
            
        }
    }
    
    @ViewBuilder
    private func NotesListView() -> some View {
        List {
            ForEach(allNotes.sortedByDate()) { note in
                Text(note.content)
                    .lineLimit(2)
            }
            .onDelete(perform: DeleteNote)
        }
    }
    
    // MARK: - LOGIC FUNCTIONS
    
    private func DeleteNote(_ indexSet: IndexSet) {
        allNotes.remove(atOffsets: indexSet)
    }
    
    private func FetchData() {
        allNotes = NOTES
        Logger.info(type: .get, content: allNotes.convertToString())
    }
    
    private func didPressPlus() {
        guard !noteText.isEmpty else { return }
        
        allNotes.insert(.init(content: noteText), at: 0)
        Logger.info(type: .create, content: noteText + " was added")
        noteText.clear()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - Extension

private extension Array where Element == Note {
    
    mutating func sortedByDate() {
        self = self.sorted { $0.timeAddendum > $1.timeAddendum }
    }
  
    func sortedByDate() -> Self {
        return self.sorted { $0.timeAddendum > $1.timeAddendum }
    }
    
    func convertToString() -> String {
        var str = ""
        for note in self {
            str += note.content
            str += "\n\t"
        }
        
        return str
    }
    
}
