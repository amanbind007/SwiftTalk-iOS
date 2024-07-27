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
    // @Environment(\.colorScheme) var theme
    @Environment(\.modelContext) private var modelContext
    @State var viewModel = StatsViewModel()
    @State private var lastSevenDaysData: [(date: Date, timeRead: Double)] = []
    @Binding var tabSelection: Int

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.dailyStats.isEmpty {
                    ZStack {
                        LinearGradient(colors: [Color.gradiantColor2, Color.gradiantColor1], startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea()
                        
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
                                    .font(.custom(Constants.Fonts.NotoSerifSB, size: 18))
                                    .padding(10)
                                    .foregroundStyle(.white)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundStyle(.blue)
                                    }
                            }
                        }
                    }

                } else {
                    List {
                        Section {
                            Chart(lastSevenDaysData, id: \.date) { day in
                                if day.timeRead > 0 {
                                    BarMark(
                                        x: .value("Date", day.date, unit: .day),
                                        y: .value("Time Read", day.timeRead / 60)
                                    )
                                    .foregroundStyle(Color.deepOrange.gradient)
                                    .annotation(position: .top) {
                                        Text(formatTime(day.timeRead))
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                } else {
                                    RuleMark(
                                        x: .value("Date", day.date, unit: .day),
                                        yStart: 0,
                                        yEnd: 1
                                    )
                                    .foregroundStyle(Color.deepOrange)
                                    .lineStyle(StrokeStyle(lineWidth: 3, dash: [5, 5]))
                                    .annotation(position: .bottom) {
                                        Text("0s")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                            .frame(height: 200)
                        }
                        header: {
                            Text("Weekly Time Spend - Chart")
                        }
                        .listRowBackground(Color.accent1)
                        
                        Section(header: Text("Daily Stats (Last 7 Active Days)")) {
                            ForEach(viewModel.dailyStats.suffix(7).reversed(), id: \.date) { stat in
                                HStack {
                                    Text(stat.date, style: .date)
                                    Spacer()
                                    Text(viewModel.formatTime(stat.timeSpentReading))
                                }
                            }
                        }
                        .listRowBackground(Color.accent1)
                        
                        if !viewModel.mostRead.isEmpty {
                            Section {
                                ForEach(viewModel.mostRead, id: \.id) { textData in
                                    ListItemView(textData: textData, parentListType: .MostReadList)
                                }
                                
                            } header: {
                                Text("Most time spend reading")
                            }
                            .listRowBackground(Color.accent1)
                        }
                        
                        if !viewModel.recentlyCompleted.isEmpty {
                            Section {
                                ForEach(viewModel.recentlyCompleted, id: \.id) { textData in
                                    ListItemView(textData: textData, parentListType: .RecentlyCompletedList)
                                }
                                
                            } header: {
                                Text("Recently Completed")
                            }
                            .listRowBackground(Color.accent1)
                        }
                        
                    }
                    .scrollContentBackground(.hidden)
                    .listRowSpacing(10)
                }
            }
            .navigationTitle("Reading Stats")
            .onAppear {
                viewModel.fetchStats(modelContext: modelContext)
                calculateLastSevenDaysData()
            }
            .background {
                LinearGradient(colors: [Color.gradiantColor2, Color.gradiantColor1], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
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
        
        if hours == 0 && minutes == 0 {
            // return String(format: "%dsec", seconds)
            return viewModel.formatTime(seconds)
        } else if hours == 0 {
            return String(format: "%dmin", minutes)
        }
        
        return String(format: "%dh %dm", hours, minutes)
    }
}

#Preview {
    StatsView(tabSelection: .constant(2))
}
