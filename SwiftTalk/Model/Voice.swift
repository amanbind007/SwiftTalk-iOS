//
//  Voices.swift
//  SwiftTalk
//
//  Created by Aman Bind on 07/04/24.
//

import Foundation

struct Voice: Identifiable {
    let id = UUID()
    let languageCode: String
    let voiceName: String
    let country: String
    let language: String
    let demoText: String
    let identifier: String
    let gender: String
    let flag: String
    var trimmedName: String {
        let pattern = "(\\w+)" // Matches one or more word characters
        let regex = try! NSRegularExpression(pattern: pattern)
        let match = regex.firstMatch(in: voiceName, options: [], range: NSRange(location: 0, length: voiceName.utf16.count))
        if let match = match, let range = Range(match.range(at: 1), in: voiceName) {
            return String(voiceName[range])
        } else {
            return voiceName // Handle unexpected formats
        }
    }
}
