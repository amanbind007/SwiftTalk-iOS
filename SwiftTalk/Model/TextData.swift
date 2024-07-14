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
    var progress: Int
    var timeSpend: Double

    init(textTitle: String?, text: String, textSource: AddNewTextOption) {
        self.id = UUID()
        self.textTitle = textTitle
        self.text = text
        self.textSource = textSource
        self.iconType = textSource.imageName
        self.dateTime = Date().timeIntervalSince1970
        self.progress = 0
        self.timeSpend = 0.0
    }
}
