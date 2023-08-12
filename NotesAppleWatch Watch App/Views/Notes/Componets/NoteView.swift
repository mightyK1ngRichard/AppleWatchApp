//
//  NoteView.swift
//  NotesAppleWatch Watch App
//
//  Created by Дмитрий Пермяков on 12.08.2023.
//

import SwiftUI

struct NoteView: View {
    var body: some View {
        Button {
            //
        } label: {
            ZStack {
                Circle()
                Image(systemName: "plus")
                    .foregroundColor(.blue)
            }
        }
        .buttonStyle(.plain)

    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
    }
}
