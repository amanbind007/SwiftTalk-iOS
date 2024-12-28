//
//  ReminderViewViewModel.swift
//  SwiftTalk
//
//  Created by Aman Bind on 07/09/24.
//

import Foundation

@Observable
class ReminderViewViewModel {
    var reminderTime = Date()
    let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    func selectedWeekDaysString(textData: TextData) -> String {
        if textData.hasReminder {
            if textData.selectedDays.isEmpty {
                // calculate today or tommorrow
                let calendar = Calendar.current
                let now = Date()
                print("Time Now : \(Date().formatted(date: .complete, time: .complete))")
                        
                let dateComponents = calendar.dateComponents([.hour, .minute, .second], from: reminderTime)
                let nowComponents = calendar.dateComponents([.hour, .minute, .second], from: now)
//                print(dateComponents.description)
//                print(nowComponents.description)
//                        
                if let dateTime = calendar.date(from: dateComponents),
                   let nowTime = calendar.date(from: nowComponents)
                {
                    if dateTime <= nowTime {
                        return "today"
                    } else {
                        return "tomorrow"
                    }
                }
                        
                return "Error comparing times"
            } else if textData.selectedDays.count == 1 {
                return weekdays[textData.selectedDays.first!]
            } else if textData.selectedDays.count == 7 {
                return "Every day"
            } else {
                let sortedDays = textData.selectedDays.sorted()
                var string = ""
                for days in sortedDays {
                    string += weekdays[days].prefix(3) + " "
                }
                string.removeLast()
                
                let weekdaysString = string.replacingOccurrences(of: " ", with: ", ")
                
                return weekdaysString
            }
        }
        
        return "Not Scheduled"
    }
}
