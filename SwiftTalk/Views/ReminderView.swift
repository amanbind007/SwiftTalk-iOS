//
//  ReminderView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 02/09/24.
//

import SwiftUI

struct ReminderView: View {
    @State private var selectedDays: Set<Int> = []
    @State var reminderTime: Date = .init()
    let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

    var selectedWeekdaysString: String {
        let sortedDays = selectedDays.sorted()

        var string = ""

        for days in sortedDays {
            string += weekdays[days].prefix(3) + " "
        }

        string.removeLast()

        let weekdaysString = string.replacingOccurrences(of: " ", with: ", ")

        return weekdaysString
    }

    var body: some View {
        VStack(spacing: 15) {
            HStack(alignment: .center) {
                DatePicker("Time", selection: $reminderTime, displayedComponents: .hourAndMinute)
                    .pickerStyle(.wheel)
            }

            HStack {
                if selectedDays.isEmpty {
                    Text("Not Scheduled")
                } else if selectedDays.count == 1 {
                    Text(weekdays[selectedDays.first!])
                } else if selectedDays.count == 7 {
                    Text("Every day")
                } else {
                    Text(selectedWeekdaysString)
                }

                Spacer()
            }

            HStack(spacing: 6) {
                ForEach(0 ..< 7) { index in

                    Button(action: {
                        if selectedDays.contains(index) {
                            selectedDays.remove(index)
                        } else {
                            selectedDays.insert(index)
                        }
                    }) {
                        HStack(spacing: 0) {
                            Capsule()
                                .foregroundStyle(Color.appTint)
                                .opacity(selectedDays.contains(index) ? 1 : 0.2)

                                .frame(width: 47, height: 35)
                                .overlay {
                                    Text(weekdays[index].prefix(3))

                                        .bold()
                                        .foregroundStyle(selectedDays.contains(index) ? Color.white : Color.secondary)
                                        .dynamicTypeSize(.medium)
                                }
                        }
                    }
                }
            }

            HStack {
                Image(systemName: "trash")

                Text("Delete")

                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    ReminderView()
}
