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
    var textSource: TextSource
    var dateTime: Double
    var progress: Int
    var estimateReadTime: String {
        let wordsPerMinute = 183
        let wordCount = text.components(separatedBy: .whitespacesAndNewlines).filter { !$0.isEmpty }.count

        let totalSeconds = Int((Double(wordCount) / Double(wordsPerMinute)) * 60)

        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60

        var result = ""

        if hours > 0 {
            result += "\(hours)hr "
        }

        if minutes > 0 || hours > 0 {
            result += "\(minutes)min "
        }

        result += "\(seconds)sec"

        return result.trimmingCharacters(in: .whitespaces)
    }

    var timeSpend: Double
    var isCompleted: Bool {
        if progress == text.count {
            return true
        }
        else {
            return false
        }
    }

    var completionDate: Double
    var confettiShown: Bool

    init(textTitle: String?, text: String, textSource: TextSource) {
        self.id = UUID()
        self.textTitle = textTitle
        self.text = text
        self.textSource = textSource
        self.dateTime = Date().timeIntervalSince1970
        self.progress = 0
        self.timeSpend = 0.0
        self.completionDate = 0.0
        self.confettiShown = false
    }
}
