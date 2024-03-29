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
    var textTitle: String
    var text: String
    var textSource: String
    var iconType: String
    var dateTime: Date

    init(textTitle: String, text: String, textSource: String, iconType: String, dateTime: Date) {
        self.textTitle = textTitle
        self.text = text
        self.textSource = textSource
        self.iconType = iconType
        self.dateTime = dateTime
    }
}
