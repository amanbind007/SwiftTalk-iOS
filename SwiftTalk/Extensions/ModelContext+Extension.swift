//
//  ModelContext+Extension.swift
//  SwiftTalk
//
//  Created by Aman Bind on 19/07/24.
//

import Foundation
import SwiftData

extension ModelContext {
    var sqliteCommand: String {
        if let url = container.configurations.first?.url.path(percentEncoded: false) {
            "sqlite3 \"\(url)\""
        } else {
            "No SQLite database found."
        }
    }
}
