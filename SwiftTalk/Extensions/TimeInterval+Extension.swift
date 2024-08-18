//
//  TimeInterval+Extension.swift
//  SwiftTalk
//
//  Created by Aman Bind on 18/08/24.
//

import Foundation

extension TimeInterval {
    func upperAbbreviatedTimeInterval() -> String {
        let seconds = self

        let hours = Int(seconds / 3600)
        let minutes = Int(seconds) / 60 % 60
        let seconds2 = Int(seconds) % 60

        if hours == 0 && minutes == 0 {
            return String(format: "%ds", seconds2)
        } else if hours == 0 {
            return String(format: "%dm", minutes)
        }

        return String(format: "%dh", hours, minutes)
    }

    func abbreviatedTimeInterval() -> String {
        let seconds = self

        let hours = Int(seconds / 3600)
        let minutes = Int(seconds) / 60 % 60
        let seconds2 = Int(seconds) % 60

        var result = ""
        if hours > 0 {
            result += "\(hours)h "
        }
        if minutes > 0 || hours > 0 {
            result += "\(minutes)m "
        }
        result += "\(seconds2)s"

        return result
    }

    func shortenedTimeInterval() -> String {
        let seconds = self

        let hours = Int(seconds / 3600)
        let minutes = Int(seconds) / 60 % 60
        let seconds2 = Int(seconds) % 60

        var result = ""
        if hours > 0 {
            result += "\(hours)hr "
        }
        if minutes > 0 || hours > 0 {
            result += "\(minutes)min "
        }
        result += "\(seconds2)sec "

        return result
    }
}
