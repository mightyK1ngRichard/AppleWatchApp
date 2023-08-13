//
//  RealmService.swift
//  NotesAppleWatch Watch App
//
//  Created by Дмитрий Пермяков on 12.08.2023.
//

import RealmSwift

class RealmService {
    static let shared = RealmService()
    
    private var realm: Realm {
        do {
            return try Realm()
        } catch {
            Logger.info(type: .error, content: error.localizedDescription)
            fatalError("Ошибка при получении экземпляра Realm: \(error.localizedDescription)")
        }
    }
    private var token: NotificationToken?
    
    func createNote(note: Note) throws {
        do {
            try realm.write {
                realm.add(note)
            }
            
        } catch {
            throw error
        }
    }
    
    func deleteItem(note: Note) throws {
        do {
            try realm.write {
                realm.delete(realm.objects(Note.self).filter({ $0.id == note.id }))
            }
        } catch {
            throw error
        }
    }
    
    func updateNote(note: Note, string: String) throws {
        if let objectToUpdate = realm.objects(Note.self).filter("id == %@", note.id).first {
            do {
                try realm.write {
                    objectToUpdate.content = string
                }
                
            } catch {
                throw error
            }
        }
    }
}
