//
//  Logger.swift
//  NotesAppleWatch Watch App
//
//  Created by Дмитрий Пермяков on 12.08.2023.
//

import Foundation

class Logger {
    
    static func info(type: LogType = .info, content: String) {
        let typeText = "\(type)".uppercased()
        var contentText: String
        switch type {
        case .get:
            contentText = "'\(content)' was getted"
        case .create:
            contentText = "'\(content)' was create"
        case .delete:
            contentText = "'\(content)' was deleted"
        default:
            contentText = content
        }
        
        print("[\(typeText)] [\(Date.now)]\n\t\(contentText)")
    }
    
    enum LogType: String {
        case get    = "get"
        case info   = "info"
        case error  = "error"
        case create = "create"
        case delete = "delete"
    }
}
