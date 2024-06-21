//
//  TextData.swift
//  SwiftTalk
//
//  Created by Aman Bind on 10/03/24.
//

import Foundation
import SwiftData

@Model
class TextData: Identifiable {
    @Attribute(.unique) var id: UUID
    var textTitle: String?
    var text: String
    var textSource: AddNewTextOption
    var iconType: String
    var dateTime: Double

    init(textTitle: String?, text: String, textSource: AddNewTextOption, iconType: String, dateTime: Double) {
        self.id = UUID()
        self.textTitle = textTitle
        self.text = text
        self.textSource = textSource
        self.iconType = iconType
        self.dateTime = dateTime
    }
}
