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
    let flagName: String
    let country: String
    
}
