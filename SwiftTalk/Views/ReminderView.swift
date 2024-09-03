//
//  ReminderView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 02/09/24.
//

import SwiftUI

struct ReminderView: View {
    @State var textData: TextData
    @State var reminderTime: Date = .init()
    let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

    var selectedWeekdaysString: String {
        let sortedDays = textData.selectedDays.sorted()

        var string = ""

        for days in sortedDays {
            string += weekdays[days].prefix(3) + " "
        }

        string.removeLast()

        let weekdaysString = string.replacingOccurrences(of: " ", with: ", ")

        return weekdaysString
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                VStack(spacing: 1) {
                    HStack {
                        Text("PREVIEW")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    
                    HStack {
                        Image(uiImage: UIImage.icon)
                            .resizable()
                            .frame(width: 45, height: 45)
                        
                        VStack {
                            HStack {
                                Text("Dummy Title")
                                    .font(.headline)
                                Spacer()
                                
                                Text("now")
                                    .font(.callout)
                                    .foregroundStyle(.secondary)
                            }
                            HStack {
                                Text("Dummy Text for Preview")
                                
                                Spacer(minLength: 0)
                            }
                        }
                    }
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                }
                .padding(.bottom, 15)
                
                HStack(alignment: .center) {
                    DatePicker("Time", selection: $reminderTime, displayedComponents: .hourAndMinute)
                        .pickerStyle(.wheel)
                }
                
                HStack {
                    if textData.selectedDays.isEmpty {
                        Text("Not Scheduled")
                    } else if textData.selectedDays.count == 1 {
                        Text(weekdays[textData.selectedDays.first!])
                    } else if textData.selectedDays.count == 7 {
                        Text("Every day")
                    } else {
                        Text(selectedWeekdaysString)
                    }
                    
                    Spacer()
                    
                    Toggle(isOn: $textData.hasReminder, label: {
                        Text("")
                    })
                }
                
                HStack(spacing: 6) {
                    ForEach(0 ..< 7) { index in
                        
                        Button(action: {
                            if textData.selectedDays.contains(index) {
                                textData.selectedDays.remove(index)
                            } else {
                                textData.selectedDays.insert(index)
                            }
                        }) {
                            HStack(spacing: 0) {
                                Capsule()
                                    .foregroundStyle(Color.appTint)
                                    .opacity(textData.selectedDays.contains(index) ? 1 : 0.2)
                                
                                    .frame(width: 47, height: 35)
                                    .overlay {
                                        Text(weekdays[index].prefix(3))
                                        
                                            .bold()
                                            .foregroundStyle(textData.selectedDays.contains(index) ? Color.white : Color.secondary)
                                            .dynamicTypeSize(.medium)
                                    }
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Set Reminder")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ReminderView(textData: TextDataPreviewProvider.textData1)
}
