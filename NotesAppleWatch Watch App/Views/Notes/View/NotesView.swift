//
//  ContentView.swift
//  NotesAppleWatch Watch App
//
//  Created by Дмитрий Пермяков on 12.08.2023.
//

import SwiftUI
import RealmSwift

struct NotesView: View {
    
    // MARK: PROPERTY
    
    @ObservedResults(Note.self) var allNotes
    private var sortedNotes: [Note] {
        allNotes.sorted { $0.timeAddendum > $1.timeAddendum }
    }
    @State private var noteText = ""
    
    // MARK: BODY
    
    var body: some View {
        NavigationStack {
            HeaderView()
            NotesListView()
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
                NavigationLink {
                    NoteView(note: note)
                    
                } label: {
                    NoteRow(note)
                }
                
            }
            .onDelete(perform: deleteNote)
        }
        
    }
    
    @ViewBuilder
    private func NoteRow(_ note: Note) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 3)
                .foregroundColor(.orange)
                .padding(.trailing, 5)
            
            Text(note.content)
                .lineLimit(2)
        }
    }
}

// MARK: - LOGIC FUNCTIONS

private extension NotesView {
    func didPressPlus() {
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
    
    func deleteNote(indexSet: IndexSet) {
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

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
