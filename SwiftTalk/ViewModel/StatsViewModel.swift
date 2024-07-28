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
        } catch {
            print("Failed to fetch stats: \(error)")
        }
    }

    func formatTime(_ timeInterval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: timeInterval) ?? "0s"
    }
}
