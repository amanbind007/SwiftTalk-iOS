//
//  StatsViewModel.swift
//  SwiftTalk
//
//  Created by Aman Bind on 16/07/24.
//

import Foundation
import SwiftData

enum StatType {
    case total
    case mean
    case median
}

@Observable
class StatsViewModel {
    var dailyStats: [DailyStats] = []
    var mostRead: [TextData] = []
    var recentlyCompleted: [TextData] = []
    var currentStreak: Int = 0
    var largestStreak: Int = 0

    var lastSevenDaysData: [(date: Date, timeRead: Double)] = []
    var lastSevenDaysDateRange: String = ""
    var lastSevenDaysTimeSpend: TimeInterval = 0
    var lastSevenDaysAverageTimeSpend: TimeInterval = 0
    var lastSevenDaysMedianTimeSpend: TimeInterval = 0
    var selectedStat: StatType = .total

    func fetchStats(modelContext: ModelContext) {
        let weeklyDataFetchDescriptor = FetchDescriptor<DailyStats>(sortBy: [SortDescriptor(\.date, order: .forward)])
        var mostReadFetchDescriptor = FetchDescriptor<TextData>(sortBy: [SortDescriptor(\.timeSpend, order: .reverse)])
        mostReadFetchDescriptor.fetchLimit = 3

        var recentlyCompletedFetchDescriptor = FetchDescriptor<TextData>(sortBy: [SortDescriptor(\.completionDate, order: .reverse)])
        recentlyCompletedFetchDescriptor.fetchLimit = 3

        do {
            dailyStats = try modelContext.fetch(weeklyDataFetchDescriptor)
            mostRead = try modelContext.fetch(mostReadFetchDescriptor).filter { textData in
                textData.timeSpend != 0.0
            }
            recentlyCompleted = try modelContext.fetch(recentlyCompletedFetchDescriptor).filter { textData in
                textData.completionDate != nil
            }
            calculateStreaks()
            calculateLastSevenDaysData()

        } catch {
            print("Failed to fetch stats: \(error)")
        }
    }

    func calculateLastSevenDaysData() {
        let calendar = Calendar.current
        let endDate = calendar.startOfDay(for: Date())
        let startDate = calendar.date(byAdding: .day, value: -6, to: endDate)!

        lastSevenDaysDateRange = "\(startDate.formatted(date: .abbreviated, time: .omitted)) -  \(endDate.formatted(date: .abbreviated, time: .omitted))"

        lastSevenDaysData = (0 ..< 7).compactMap { dayOffset in
            guard let date = calendar.date(byAdding: .day, value: dayOffset, to: startDate) else { return nil }
            let timeRead = dailyStats.first { calendar.isDate($0.date, inSameDayAs: date) }?.timeSpentReading ?? 0
            return (date: date, timeRead: timeRead)
        }

        // Total Time Spend (in last 7 days)
        lastSevenDaysTimeSpend = 0
        for day in lastSevenDaysData {
            lastSevenDaysTimeSpend += day.timeRead
        }

        // Average Time Spend (in last 7 days)
        lastSevenDaysAverageTimeSpend = lastSevenDaysTimeSpend / 7

        // Total Time Spend (in last 7 days)
        let sortedData = lastSevenDaysData.sorted { $0.timeRead < $1.timeRead }

        let count = sortedData.count
        let middleIndex = count / 2

        if count % 2 == 1 {
            // Odd number of elements, median is the middle value
            lastSevenDaysMedianTimeSpend = sortedData[middleIndex].timeRead
        } else {
            // Even number of elements, median is the average of the middle two values
            let lowerMiddle = sortedData[middleIndex - 1].timeRead
            let upperMiddle = sortedData[middleIndex].timeRead
            lastSevenDaysMedianTimeSpend = (lowerMiddle + upperMiddle) / 2
        }
    }
    
    func calculateStreaks() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        // Sort stats by date in descending order
        let sortedStats = dailyStats.sorted { $0.date > $1.date }
        currentStreak = 0
        largestStreak = 0
        
        var streak = 0
        var isReadingToday = false
        
        for (index, stat) in sortedStats.enumerated() {
            let statDate = calendar.startOfDay(for: stat.date)
            
            // Check if the user read today
            if index == 0, calendar.isDate(statDate, inSameDayAs: today) {
                isReadingToday = true
            }
            
            if index > 0 {
                let previousDate = calendar.startOfDay(for: sortedStats[index - 1].date)
                let daysDifference = calendar.dateComponents([.day], from: statDate, to: previousDate).day ?? 0
                
                // If consecutive day, increase streak
                if daysDifference == 1 {
                    streak += 1
                } else {
                    // Not consecutive, end current streak
                    largestStreak = max(largestStreak, streak)
                    streak = 0
                }
            } else {
                // First day, start the streak
                streak = 1
            }
        }
        
        // Update largest streak for the last streak in the list
        largestStreak = max(largestStreak, streak)
        
        // If user read today, set current streak, otherwise reset to 0
        currentStreak = isReadingToday ? streak : 0
    }


    func displayTimeSpend() -> String {
        switch selectedStat {
        case .total:
            return lastSevenDaysTimeSpend.shortenedTimeInterval()
        case .mean:
            return lastSevenDaysAverageTimeSpend.shortenedTimeInterval()
        case .median:
            return lastSevenDaysMedianTimeSpend.shortenedTimeInterval()
        }
    }
}
