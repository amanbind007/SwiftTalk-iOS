//
//  StatsViewModel.swift
//  SwiftTalk
//
//  Created by Aman Bind on 16/07/24.
//

import Foundation
import SwiftData

@Observable
class StatsViewModel {
    var dailyStats: [DailyStats] = []
    var mostRead: [TextData] = []
    var recentlyCompleted: [TextData] = []
    var currentStreak: Int = 0
    var largestStreak: Int = 0

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
        } catch {
            print("Failed to fetch stats: \(error)")
        }
    }

    func calculateStreaks() {
        let sortedStats = dailyStats.sorted { $0.date > $1.date }
        var lastDate: Date?

        for stat in sortedStats {
            let calendar = Calendar.current
            if let last = lastDate {
                let daysBetween = calendar.dateComponents([.day], from: stat.date, to: last).day ?? 0
                if daysBetween == 1 {
                    currentStreak += 1
                } else {
                    largestStreak = max(largestStreak, currentStreak)
                    currentStreak = 1
                }
            } else {
                currentStreak = 1
            }
            lastDate = stat.date
        }

        largestStreak = max(largestStreak, currentStreak)
    }
}
