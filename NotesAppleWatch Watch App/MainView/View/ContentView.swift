//
//  ContentView.swift
//  NotesAppleWatch Watch App
//
//  Created by Дмитрий Пермяков on 12.08.2023.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    // MARK: PROPERTY
    
    @ObservedResults(Note.self) var allNotes
    private var sortedNotes: [Note] {
        allNotes.sorted { $0.timeAddendum > $1.timeAddendum }
    }
    @State private var noteText = ""
    
    // MARK: BODY
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderView()
                NotesListView()
            }
        }
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
            ForEach(sortedNotes) { note in
                Text(note.content)
                    .lineLimit(2)
            }
            .onDelete(perform: deleteNote)
        }
    }
    
    // MARK: - LOGIC FUNCTIONS

    private func didPressPlus() {
        guard !noteText.isEmpty else { return }
        let note = Note()
        note.content = noteText
        do {
            try RealmService.shared.createNote(note: note)
            Logger.info(type: .create, content: note.content)
        } catch {
            Logger.info(type: .error, content: error.localizedDescription)
        }
        noteText.clear()
    }
    
    private func deleteNote(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let deletedNote = sortedNotes[index]
        do {
            try RealmService.shared.deleteItem(note: deletedNote)
            Logger.info(type: .delete, content: deletedNote.content)
            
        } catch {
            Logger.info(type: .error, content: error.localizedDescription)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - Extension

//private extension Array where Element == Note {
//
//    mutating func sortByDate() {
//        self.sort { $0.timeAddendum > $1.timeAddendum }
//    }
//
//    func sortedByDate() -> Self {
//        return self.sorted { $0.timeAddendum > $1.timeAddendum }
//    }
//
//    func convertToString() -> String {
//        var str = ""
//        for note in self {
//            str += note.content
//            str += "\n\t"
//        }
//
//        return str
//    }
//
//}
