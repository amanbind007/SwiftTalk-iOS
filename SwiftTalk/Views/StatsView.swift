//
//  StatsView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 16/07/24.
//

import Charts
import SwiftUI

struct StatsView: View {
    @Environment(\.modelContext) private var modelContext
    @State var viewModel = StatsViewModel()
    @State private var lastSevenDaysData: [(date: Date, timeRead: Double)] = []

    var body: some View {
        NavigationStack {
            
            if viewModel.dailyStats.isEmpty {
                
                
                
                
                
                
                
            }
            
            
            List {
                Chart(lastSevenDaysData, id: \.date) { day in
                    if day.timeRead > 0 {
                        BarMark(
                            x: .value("Date", day.date, unit: .day),
                            y: .value("Time Read", day.timeRead / 3600)
                        )
                        .foregroundStyle(Color.blue.gradient)
                        .annotation(position: .top) {
                            Text(formatTime(day.timeRead))
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    } else {
                        RuleMark(
                            x: .value("Date", day.date, unit: .day),
                            yStart: 0,
                            yEnd: 0.1
                        )
                        .foregroundStyle(Color.gray)
                        .lineStyle(StrokeStyle(lineWidth: 2, dash: [5, 5]))
                        .annotation(position: .bottom) {
                            Text("Nil")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .frame(height: 200)
                .tint(Color.green)
                
                Section(header: Text("Daily Stats (Last 7 Days)")) {
                    ForEach(viewModel.dailyStats.suffix(7).reversed(), id: \.date) { stat in
                        HStack {
                            Text(stat.date, style: .date)
                            Spacer()
                            Text(viewModel.formatTime(stat.timeSpentReading))
                        }
                    }
                }
            }
            .navigationTitle("Reading Stats")
            .onAppear {
                viewModel.fetchStats(modelContext: modelContext)
                calculateLastSevenDaysData()
            }
        }
    }
    
    func calculateLastSevenDaysData() {
        let calendar = Calendar.current
        let endDate = calendar.startOfDay(for: Date())
        let startDate = calendar.date(byAdding: .day, value: -6, to: endDate)!
        
        lastSevenDaysData = (0 ..< 7).compactMap { dayOffset in
            guard let date = calendar.date(byAdding: .day, value: dayOffset, to: startDate) else { return nil }
            let timeRead = viewModel.dailyStats.first { calendar.isDate($0.date, inSameDayAs: date) }?.timeSpentReading ?? 0
            return (date: date, timeRead: timeRead)
        }
    }
    
//    private func maxReadingTime() -> Double {
//        return lastSevenDaysData.map { $0.timeRead }.max() ?? 600 // Default to 10 min if no data
//    }
    
    private func formatTime(_ seconds: Double) -> String {
        let hours = Int(seconds / 3600)
        let minutes = Int((seconds.truncatingRemainder(dividingBy: 3600)) / 60)
        
        if hours == 0 {
            return String(format: "%dmin", minutes)
        }
        
        return String(format: "%dh %dm", hours, minutes)
    }
}

#Preview {
    StatsView()
}
