//
//  ReminderView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 02/09/24.
//

import SwiftUI

struct ReminderView: View {
    @State var textData: TextData
    @State var viewModel = ReminderViewViewModel()
    
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
                    DatePicker("Time", selection: $viewModel.reminderTime, displayedComponents: .hourAndMinute)
                        .pickerStyle(.wheel)
                        .disabled(textData.hasReminder)
                        .onTapGesture {
                            print("heeol")
                        }
                }
                
                HStack {
                    Text(viewModel.selectedWeekDaysString(textData: textData))
                                  
                    Spacer()
                    
                    Toggle(isOn: $textData.hasReminder, label: {})
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
                                        Text(viewModel.weekdays[index].prefix(3))
                                        
                                            .bold()
                                            .foregroundStyle(textData.selectedDays.contains(index) ? Color.white : Color.secondary)
                                            .dynamicTypeSize(.medium)
                                    }
                            }
                        }
                    }
                }
                .disabled(textData.hasReminder)
                .grayscale(textData.hasReminder ? 1 : 0)
                Spacer()
                
                Text("*Switch off the reminder to make changes")
                    .font(.caption)
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
