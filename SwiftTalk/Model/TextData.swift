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
    var creationDateTime: Date
    var creationDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM, yyyy • h:mm a"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: creationDateTime)
    }

    var relativeCreationDateString: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        let relativeDate = formatter.localizedString(for: creationDateTime, relativeTo: Date.now)
        return relativeDate
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

    var timeSpend: TimeInterval
    var timeSpendString: String {
        let hours = Int(timeSpend) / 3600
        let minutes = (Int(timeSpend) % 3600) / 60
        let seconds = Int(timeSpend) % 60

        var result = ""
        if hours > 0 {
            result += "\(hours)hr "
        }
        if minutes > 0 {
            result += "\(minutes)min "
        }
        if seconds > 0 || (hours == 0 && minutes == 0) {
            result += "\(seconds)sec"
        }

        result = result == "0sec" ? "Not Read Yet" : result
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
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .short
            let relativeDate = formatter.localizedString(for: completionDate, relativeTo: Date.now)
            return relativeDate
        }
        return nil
    }

    var confettiShown: Bool

    var lastAccess: Date

    init(textTitle: String?, text: String, textSource: TextSource) {
        self.id = UUID()
        self.textTitle = textTitle
        self.text = text
        self.textSource = textSource
        self.creationDateTime = Date()
        self.progress = 0
        self.timeSpend = 0.0
        self.completionDate = nil
        self.confettiShown = false
        self.lastAccess = Date()
    }
}
