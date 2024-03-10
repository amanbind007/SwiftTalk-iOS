//
//  TextData.swift
//  SwiftTalk
//
//  Created by Aman Bind on 10/03/24.
//

import Foundation
import SwiftData

@Model
class TextData {
    
    var text: String
    var dateTime: Date
    
    init(text: String, dateTime: Date) {
        self.text = text
        self.dateTime = dateTime
    }
    
}
