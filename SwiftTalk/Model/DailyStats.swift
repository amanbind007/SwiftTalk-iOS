//
//  DailyStats.swift
//  SwiftTalk
//
//  Created by Aman Bind on 16/07/24.
//

import SwiftData
import Foundation

@Model
class DailyStats {
    var date: Date
    var timeSpentReading: TimeInterval
    
    init(date: Date, timeSpentReading: TimeInterval) {
        self.date = date
        self.timeSpentReading = timeSpentReading
    }
}
