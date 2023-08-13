//
//  NoteView.swift
//  NotesAppleWatch Watch App
//
//  Created by Дмитрий Пермяков on 12.08.2023.
//

import SwiftUI

struct NoteView: View {
    // MARK: PROPERTY
    
    @State private var textEditor    = ""
    @State private var editorPressed = false
    var note: Note
    
    // MARK: BODY
    
    var body: some View {
        if editorPressed {
            VStack {
                TextField("Редатирование", text: $textEditor)
                    .foregroundColor(.white)
                
                Button {
                    try? RealmService.shared.updateNote(note: note, string: textEditor)
                    editorPressed = false
                    
                } label: {
                    Text("Сохранить")
                        .font(.caption2)
                        .foregroundColor(.orange)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .buttonStyle(PlainButtonStyle())

                       
                Spacer()
            }
            .overlay(alignment: .bottomTrailing) {
                Footer()
            }
            
        } else {
            ContentView()
            .overlay(alignment: .bottomTrailing) {
                Footer()
            }
        }
    }
    
    // MARK: UI FUNCTIONS
    
    private func ContentView() -> some View {
        ScrollView(showsIndicators: false) {
            Header()
            Text(note.content)
                .font(.system(.caption))
        }
    }
    
    private func Header() -> some View {
        HStack {
            Stick()
            Image(systemName: "note.text")
            Stick()
        }
        .foregroundColor(.orange)
    }
    
    private func Stick() -> some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(height: 3)
    }
    
    private func Footer() -> some View {
        HStack {
            Button {
                textEditor = note.content
                editorPressed.toggle()
                
            } label: {
                Image(systemName: "square.and.pencil.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
                    .foregroundColor(.orange)
            }
            .buttonStyle(PlainButtonStyle())

        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        let currentNote = Note()
//        currentNote.content = "Просто что-то для заметки, только надо очень мнного текста, чтобы было много строк все дела, чтоб не влезало и крч просто ну вот я что-то сгенерировал"
        NoteView(note: currentNote)
    }
}
