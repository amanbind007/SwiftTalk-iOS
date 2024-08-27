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
    @State var statsVM = StatsViewModel()
    
    // Stats Tab/Home Tab
    @Binding var tabSelection: Int
    
    var body: some View {
        NavigationStack {
            VStack {
                if statsVM.dailyStats.isEmpty {
                    EmptyStatsView
                    
                } else {
                    StatsListView
                }
            }
            .navigationTitle("Reading Stats")
            .toolbarBackground(Color.navbar, for: .navigationBar)
            .onAppear {
                statsVM.fetchStats(modelContext: modelContext)
            }
            .background {
                BackgroundView()
            }
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
                            Text("\(statsVM.currentStreak)")
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
                            Text("\(statsVM.largestStreak)")
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
                    
                    Text("\(statsVM.lastSevenDaysData.last!.timeRead.shortenedTimeInterval())")
                        .font(NotoFont.Bold(35))
                        .foregroundStyle(LinearGradient(colors: [.appTint.opacity(0.7), .appTint, .appTint.opacity(0.7)], startPoint: .top, endPoint: .bottom))
                }
            } header: {
                Text("DAILY USAGE")
            }
            
            Section {
                VStack(alignment: .leading) {
                    HStack {
                        Picker("Stat", selection: $statsVM.selectedStat) {
                            Text("Total").tag(StatType.total)
                            Text("Mean").tag(StatType.mean)
                            Text("Median").tag(StatType.median)
                        }
                        .pickerStyle(.segmented)
                        
                        Spacer()
                    }
                    
                    Text(statsVM.selectedStat.displayValue(using: statsVM.lastSevenDaysTimeSpend, lastSevenDaysAverageTimeSpend: statsVM.lastSevenDaysAverageTimeSpend, lastSevenDaysMedianTimeSpend: statsVM.lastSevenDaysMedianTimeSpend))
                        .font(NotoFont.Bold(35))
                        .foregroundStyle(LinearGradient(colors: [.appTint.opacity(0.7), .appTint, .appTint.opacity(0.7)], startPoint: .top, endPoint: .bottom))
                }
            } header: {
                Text("LAST SEVEN DAYS USAGE")
            }
            
            Section {
                Chart(statsVM.lastSevenDaysData, id: \.date) { day in
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
                        
                        if statsVM.selectedStat == .mean {
                            RuleMark(y: .value("Mean", statsVM.lastSevenDaysAverageTimeSpend / 60))
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
                        if statsVM.selectedStat == .median {
                            RuleMark(y: .value("Median", statsVM.lastSevenDaysMedianTimeSpend / 60))
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
            
            if !statsVM.mostRead.isEmpty {
                Section {
                    ForEach(statsVM.mostRead, id: \.id) { textData in
                        ListItemView(textData: textData, parentListType: .MostReadList)
                    }
                    
                } header: {
                    Text("Most time spend reading")
                }
            }
            
            if !statsVM.recentlyCompleted.isEmpty {
                Section {
                    ForEach(statsVM.recentlyCompleted, id: \.id) { textData in
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
