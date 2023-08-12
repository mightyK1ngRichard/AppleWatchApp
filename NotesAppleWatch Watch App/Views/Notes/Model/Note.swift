//
//  Note.swift
//  NotesAppleWatch Watch App
//
//  Created by Дмитрий Пермяков on 12.08.2023.
//

import Foundation
import RealmSwift

class Note: Object, Identifiable {
    @Persisted private(set) var id           = UUID()
    @Persisted private(set) var timeAddendum = Date.now
    @Persisted var content                   : String
}
