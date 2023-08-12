//
//  Note.swift
//  NotesAppleWatch Watch App
//
//  Created by Дмитрий Пермяков on 12.08.2023.
//

import Foundation

struct Note: Identifiable {
    let id      = UUID()
    var content : String
    private(set) var timeAddendum : Date = .now
}


// MARK: - Test model
let NOTES: [Note] = [
    .init(content: "Просто какая-то заметка 1"),
    .init(content: "Просто какая-то заметка 2"),
    .init(content: "Просто какая-то заметка 3"),
    .init(content: "Просто какая-то заметка 4"),
    .init(content: "Просто какая-то заметка 5"),
    .init(content: "Просто какая-то заметка 6"),
    .init(content: "Просто какая-то заметка 7"),
    .init(content: "Просто какая-то заметка 8"),
]
