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
    var dateTime: Date
    var creationDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM, yyyy • h:mm a"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: dateTime)
    }

    var relativeCreationDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM, yyyy • h:mm a"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: dateTime)
    }

    var progress: Int
    var progressPercentage: Double {
        guard text.count > 0 else { return 0.00 }
        return Double(progress) / Double(text.count) * 100
    }

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
    var timeSpendString: String {
        let hours = Int(timeSpend) / 3600
        let minutes = (Int(timeSpend) % 3600) / 60
        let seconds = Int(timeSpend) % 60

        var result = "Not Read Yet"
        if hours > 0 {
            result += "\(hours)hr "
        }
        if minutes > 0 {
            result += "\(minutes)min "
        }
        if seconds > 0 || (hours == 0 && minutes == 0) {
            result += "\(seconds)sec"
        }

        return result.trimmingCharacters(in: .whitespaces)
    }

    var isCompleted: Bool {
        if progress == text.count {
            return true
        } else {
            return false
        }
    }

    var completionDate: Date?
    var completionDateString: String? {
        if let completionDate = completionDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "E, d MMM, yyyy • h:mm a"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            return formatter.string(from: completionDate)
        }
        return nil
    }

    var relativeCompletionDateString: String? {
        if let completionDate = completionDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "E, d MMM, yyyy • h:mm a"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            return formatter.string(from: completionDate)
        }
        return nil
    }

    var confettiShown: Bool

    init(textTitle: String?, text: String, textSource: TextSource) {
        self.id = UUID()
        self.textTitle = textTitle
        self.text = text
        self.textSource = textSource
        self.dateTime = Date()
        self.progress = 0
        self.timeSpend = 0.0
        self.completionDate = nil
        self.confettiShown = false
    }
}
