//
//  StatsView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 16/07/24.
//

import Charts
import Lottie
import SwiftUI

struct StatsView: View {
    @Environment(\.modelContext) private var modelContext
    @State var viewModel = StatsViewModel()
    @State private var lastSevenDaysData: [(date: Date, timeRead: Double)] = []
    @State private var lastSevenDaysTimeSpend: TimeInterval = 0
    @State private var lastSevenDaysAverageTimeSpend: TimeInterval = 0
    @State private var lastSevenDaysMedianTimeSpend: TimeInterval = 0
    @State private var lastSevenDayNameString: String = ""
    @Binding var tabSelection: Int
    
    @State private var selectedStat: StatType = .total

    enum StatType {
        case total
        case mean
        case median
        
        func displayValue(using total: TimeInterval, lastSevenDaysAverageTimeSpend: TimeInterval, lastSevenDaysMedianTimeSpend: TimeInterval) -> String {
            switch self {
            case .total:
                return total.shortenedTimeInterval()
            case .mean:
                return lastSevenDaysAverageTimeSpend.shortenedTimeInterval()
            case .median:
                return lastSevenDaysMedianTimeSpend.shortenedTimeInterval()
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.dailyStats.isEmpty {
                    EmptyStatsView
                    
                } else {
                    StatsListView
                }
            }
            .navigationTitle("Reading Stats")
            .toolbarBackground(Color.navbar, for: .navigationBar)
            .onAppear {
                viewModel.fetchStats(modelContext: modelContext)
                calculateLastSevenDaysData()
            }
            .background {
                BackgroundView()
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
}

extension StatsView {
    @ViewBuilder
    var EmptyStatsView: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                LottieView(animation: .named("StatsChartAnimation"))
                    .playing(loopMode: .loop)
                    .frame(height: 250)
                
                Text("I have no stats to show! (skill issue😒)")
                    .padding(.top, 30)
                
                Button {
                    tabSelection = 1
                } label: {
                    Text("Start reading some text to build stats")
                        .font(NotoFont.SemiBold(18))
                        .padding(10)
                        .foregroundStyle(.white)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.blue)
                        }
                }
            }
        }
    }
}

extension StatsView {
    @ViewBuilder
    var StatsListView: some View {
        List {
            Section("STREAK") {
                HStack {
                    Spacer()
                    
                    VStack {
                        Text("Current Streak")
                            .font(NotoFont.Regular(15))
                        
                        HStack(alignment: .lastTextBaseline) {
                            Text("\(viewModel.currentStreak)")
                                .font(NotoFont.Bold(44))
                                .foregroundStyle(LinearGradient(colors: [.appTint.opacity(0.7), .appTint, .appTint.opacity(0.7)], startPoint: .top, endPoint: .bottom))
                            
                            Text("Day(s)")
                                .font(NotoFont.Regular(13))
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    Spacer()
                    Divider()
                    Spacer()
                    
                    VStack {
                        Text("Largest Streak")
                            .font(NotoFont.Regular(15))
                            
                        HStack(alignment: .lastTextBaseline) {
                            Text("\(viewModel.largestStreak)")
                                .font(NotoFont.Bold(44))
                                .foregroundStyle(LinearGradient(colors: [.appTint.opacity(0.7), .appTint, .appTint.opacity(0.7)], startPoint: .top, endPoint: .bottom))
                            Text("Day(s)")
                                .font(NotoFont.Regular(13))
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    Spacer()
                }
            }
            
            Section {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        
                        Text("\(Date.now.formatted(date: .complete, time: .omitted))")
                            .font(NotoFont.Regular(15))
                            .foregroundStyle(.secondary)
                    }
                    
                    Text("\(lastSevenDaysData.last!.timeRead.shortenedTimeInterval())")
                        .font(NotoFont.Bold(35))
                        .foregroundStyle(LinearGradient(colors: [.appTint.opacity(0.7), .appTint, .appTint.opacity(0.7)], startPoint: .top, endPoint: .bottom))
                }
            } header: {
                Text("DAILY USAGE")
            }
            
            Section {
                VStack(alignment: .leading) {
                    HStack {
                        Picker("Stat", selection: $selectedStat) {
                            Text("Total").tag(StatType.total)
                            Text("Mean").tag(StatType.mean)
                            Text("Median").tag(StatType.median)
                        }
                        .pickerStyle(.segmented)
                        
                        Spacer()
                    }
                    
                    Text(selectedStat.displayValue(using: lastSevenDaysTimeSpend, lastSevenDaysAverageTimeSpend: lastSevenDaysAverageTimeSpend, lastSevenDaysMedianTimeSpend: lastSevenDaysMedianTimeSpend))
                        .font(NotoFont.Bold(35))
                        .foregroundStyle(LinearGradient(colors: [.appTint.opacity(0.7), .appTint, .appTint.opacity(0.7)], startPoint: .top, endPoint: .bottom))
                }
            } header: {
                Text("LAST SEVEN DAYS USAGE")
            }
            
            Section {
                Chart(lastSevenDaysData, id: \.date) { day in
                    if day.timeRead > 0 {
                        BarMark(
                            x: .value("Date", day.date, unit: .day),
                            y: .value("Time Read", day.timeRead / 60)
                        )
                        .foregroundStyle(Color.appTint.gradient)
                        .annotation(position: .top) {
                            Text(day.timeRead.upperAbbreviatedTimeInterval())
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                        
                        if selectedStat == .mean {
                            RuleMark(y: .value("Mean", lastSevenDaysAverageTimeSpend / 60))
                                .foregroundStyle(Color.red)
                                .lineStyle(StrokeStyle(lineWidth: 0.5, dash: [3, 1]))
                                .annotation(position: .top,
                                            alignment: .topTrailing)
                            {
                                Text("Mean")
                                    .fontDesign(.serif)
                                    .font(.caption)
                            }
                        }
                        if selectedStat == .median {
                            RuleMark(y: .value("Median", lastSevenDaysMedianTimeSpend / 60))
                                .foregroundStyle(Color.red)
                                .lineStyle(StrokeStyle(lineWidth: 0.5, dash: [3, 1]))
                                .annotation(position: .top,
                                            alignment: .topTrailing)
                            {
                                Text("Median")
                                    .fontDesign(.serif)
                                    .font(.caption)
                            }
                        }
                    } else {
                        RuleMark(
                            x: .value("Date", day.date, unit: .day),
                            yStart: 0,
                            yEnd: 1
                        )
                        .foregroundStyle(Color.appTint)
                        .lineStyle(StrokeStyle(lineWidth: 3, dash: [5, 5]))
                        .annotation(position: .bottom) {
                            Text("0s")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                .fontDesign(.serif)
                .frame(height: 200)
            }
            header: {
                Text("LAST SEVEN DAY TIME SPEND - Chart")
            }
            
            if !viewModel.mostRead.isEmpty {
                Section {
                    ForEach(viewModel.mostRead, id: \.id) { textData in
                        ListItemView(textData: textData, parentListType: .MostReadList)
                    }
                    
                } header: {
                    Text("Most time spend reading")
                }
            }
            
            if !viewModel.recentlyCompleted.isEmpty {
                Section {
                    ForEach(viewModel.recentlyCompleted, id: \.id) { textData in
                        ListItemView(textData: textData, parentListType: .RecentlyCompletedList)
                    }
                    
                } header: {
                    Text("Recently Completed")
                }
            }
            
            Spacer(minLength: 150)
                .listRowBackground(Color.clear)
        }
        .scrollContentBackground(.hidden)
        .listRowSpacing(10)
    }
}

#Preview {
    StatsView(tabSelection: .constant(2))
}
