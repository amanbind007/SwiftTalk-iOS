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
    @Binding var tabSelection: Int

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
            Section {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        
                        Text("\(Date.now.formatted(date: .complete, time: .omitted))")
                            .font(NotoFont.Regular(15))
                    }
                    
                    Text("\(lastSevenDaysData.last!.timeRead.shortenedTimeInterval())")
                        .font(NotoFont.Bold(35))
                        .foregroundStyle(LinearGradient(colors: [.appTint.opacity(0.7), .appTint, .appTint.opacity(0.7)], startPoint: .top, endPoint: .bottom))
                }
            } header: {
                Text("USAGE")
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
                Text("Weekly Time Spend - Chart")
            }
            
            Section(header: Text("Daily Stats (Last 7 Active Days)")) {
                ForEach(viewModel.dailyStats.suffix(7).reversed(), id: \.date) { stat in
                    HStack {
                        Text(stat.date, style: .date)
                        Spacer()
                        Text(stat.timeSpentReading.shortenedTimeInterval())
                    }
                }
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
        }
        .scrollContentBackground(.hidden)
        .listRowSpacing(10)
    }
}

#Preview {
    StatsView(tabSelection: .constant(2))
}
