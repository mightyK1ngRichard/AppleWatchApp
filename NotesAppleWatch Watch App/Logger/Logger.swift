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
        print("[\(typeText)] [\(Date.now)]\n\t\(content)")
    }
    
    enum LogType: String {
        case get    = "get"
        case info   = "info"
        case error  = "error"
        case create = "create"
        case delete = "delete"
    }
}
