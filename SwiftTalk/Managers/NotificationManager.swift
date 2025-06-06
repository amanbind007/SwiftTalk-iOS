//
//  NotificationManager.swift
//  SwiftTalk
//
//  Created by Aman Bind on 03/09/24.
//

import Foundation
import NotificationCenter

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func requestAuthorization() {
            let options: UNAuthorizationOptions = [.alert, .sound, .badge]
            UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
                if let error = error {
                    print("Notification Authorization ERROR: \(error)")
                } else {
                    print("Successfully Authorized Notification")
                }
            }
        }
    
    func scheduleNotifications(for textData: TextData) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder: \(textData.textTitle!)"
        content.body = textData.text
        content.sound = UNNotificationSound.default
        
        print("Scheduling Reminder : \(textData.textTitle!)")
        
        for day in textData.selectedDays {
            let identifier = self.createIdentifier(noteId: textData.id, weekday: day)
            let trigger = self.createTrigger(weekday: day, time: textData.reminderTime!)
            
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                }
            }
        }
        
        if textData.selectedDays.isEmpty {
            let identifier = self.createIdentifier(noteId: textData.id, weekday: 0)
            let trigger = self.createTrigger(weekday: 0, time: textData.reminderTime!)
            
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                }
            }
        }
    }
    
    func deleteNotifications(for noteId: UUID) {
        print("delete notification : \(noteId)")
        let identifiers = (0 ... 6).map { self.createIdentifier(noteId: noteId, weekday: $0) }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
    private func createIdentifier(noteId: UUID, weekday: Int) -> String {
        return "\(noteId.uuidString)_day\(weekday)"
    }
    
    private func createTrigger(weekday: Int, time: Date) -> UNCalendarNotificationTrigger {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.hour, .minute], from: time)
        dateComponents.weekday = weekday + 1 // UNCalendarNotificationTrigger uses 1-7 for weekdays
        
        return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    }
}
