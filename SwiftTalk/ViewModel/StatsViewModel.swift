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

    func fetchStats(modelContext: ModelContext) {
        let calendar = Calendar.current
        let now = Date()

        let fetchDescriptor = FetchDescriptor<DailyStats>(sortBy: [SortDescriptor(\.date, order: .forward)])

        do {
            dailyStats = try modelContext.fetch(fetchDescriptor)
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
