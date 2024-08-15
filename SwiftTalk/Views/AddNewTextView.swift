//
//  NewTextView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 08/03/24.
//

import AVFoundation
import SwiftData
import SwiftUI

struct AddNewTextView: View {
    @Environment(\.colorScheme) private var theme
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Query private var dailyStats: [DailyStats]
    
    @State var speechManager: SpeechSynthesizer = .init()
    
    @AppStorage("selectedVoice") var selectedVoiceIdentifier = "com.apple.speech.synthesis.voice.Trinoids"
    @AppStorage("selectedVoiceFlag") var selectedVoiceFlagIcon = "usa"

    @State var addNewTextVM: AddNewTextViewModel = .init()
    @State var textData: TextData
    @State var isEditing: Bool = false
    @State var isFocused: Bool = false
    
    @State var showAlertTextNotSaved: Bool = false
    @State var showAlertNoText: Bool = false
    @State var showEditAlert: Bool = false
    @State var isTextDataSaved: Bool
    @State var showContinue: Bool
    @State var isFinished: Bool = false
    @State var showConfettiAnimation: Bool = false
    @Binding var showTabView: Bool
    
    init(textData: TextData, isEditing: Bool, isFocused: Bool, isSaved: Bool, showTabView: Binding<Bool>) {
        self.textData = textData
        self.isEditing = isEditing
        self.isFocused = isFocused
        self.isTextDataSaved = isSaved
        
        if textData.progress > 0 && textData.progress < textData.text.count {
            self.showContinue = true
        } else {
            self.showContinue = false
        }
        
        self._showTabView = showTabView
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                if isEditing {
                    HStack {
                        if !isTextDataSaved {
                            Button {
                                if verifyText(text: textData.text) {
                                    DataCoordinator.shared.saveObject(text: textData.text, title: nil, textSource: textData.textSource)
                                    dismiss()
                                } else {
                                    showAlertNoText.toggle()
                                }
                                
                            } label: {
                                BannerButton(iconSystemName: "square.and.arrow.down", color: .green, text: "Save")
                            }
                        }
                        
                        Button {
                            if let pasteString = addNewTextVM.pasteboard.string {
                                textData.text = pasteString
                            }
                        } label: {
                            BannerButton(iconSystemName: "list.clipboard", color: .blue, text: "Paste")
                        }
                        
                        Button {
                            textData.text = ""
                        } label: {
                            BannerButton(iconSystemName: "delete.backward", color: .red, text: "Delete")
                        }
                    }
                    .padding(5)
                }
                
                Divider()
                
                GeometryReader { proxy in
                    TextView(text: $textData.text, highlightedRange: $speechManager.highlightedRange, editing: $isEditing, focused: $isFocused) { startIndex in
                        if !isEditing {
                            speechManager.play(text: textData.text, voice: selectedVoiceIdentifier, from: startIndex)
                        }
                        
                        showContinue = false
                    }
                    .frame(width: proxy.size.width, height: proxy.size.height)
                }
                
                Divider()
                
                if speechManager.speechState == .speaking || speechManager.speechState == .paused {
                    LinearProgressBar(
                        value: Double(speechManager.currentCompletedIndex + speechManager.startIndex),
                        total: Double(textData.text.count),
                        color: textData.textSource.color
                    )
                    .frame(height: 12)
                    .padding(5)
                }
            }
            
            if !isEditing {
                // Bottom Control Panel
                BottomPlayerPanel
            }
        }
        .onAppear(perform: {
            showTabView = false
        })
        .onDisappear(perform: {
            textData.text = textData.text.trimEndWhitespaceAndNewlines()
            showTabView = true
        })
        .onChange(of: speechManager.highlightedRange?.upperBound) {
            if let highlightedRange = speechManager.highlightedRange {
                if textData.progress < highlightedRange.upperBound {
                    textData.progress = highlightedRange.upperBound
                }
                
                if textData.text.count == textData.progress {
                    showConfettiAnimation = true
                    textData.completionDate = Date()
                }
            }
        }
        .onChange(of: speechManager.totalPlayTime) {
            textData.timeSpend += speechManager.totalPlayTime
            saveDailyStats()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("SwiftTalk")
        .navigationBarBackButtonHidden()
        .overlay(
            ConfettiView(textData: $textData, showConfettiAnimation: $showConfettiAnimation)
        )
        
        .toolbar(content: {
            ToolbarItemGroup(placement: .topBarLeading) {
                HStack {
                    Button(role: .cancel) {
                        if !isTextDataSaved && verifyText(text: textData.text) {
                            speechManager.stopSpeakingText()
                            showAlertTextNotSaved.toggle()

                        } else {
                            speechManager.stopSpeakingText()
                            dismiss()
                        }

                    } label: {
                        BannerButton(iconSystemName: "chevron.left", color: .accentColor, text: "")
                    }
                    .alert(isPresented: $showAlertTextNotSaved, content: {
                        Alert(
                            title: Text("Not Saved"),
                            message: Text("Do you want to save this text?"),
                            primaryButton: .default(Text("Yes, save it!"),
                                                    action: {
                                                        DataCoordinator.shared.saveObject(text: textData.text, title: textData.textTitle, textSource: textData.textSource)

                                                        dismiss()
                                                    }),
                            secondaryButton: .cancel {
                                dismiss()
                            }
                        )
                    })
                }
            }
            
        })
        .toolbar(content: {
            ToolbarItemGroup(placement: .topBarTrailing) {
                CustomSwitch(isOn: $isEditing, showEditAlert: $showEditAlert)
            }
        })
        .alert(isPresented: $showAlertNoText, content: {
            Alert(
                title: Text("No Text"),
                message: Text("Add some text to read/save out")
            )
        })
        .alert("Are you sure?", isPresented: $showEditAlert) {
            Button("Cancel", role: .cancel) {
                // Do nothing
            }
            
            Button("OK") {
                textData.progress = 0
                textData.completionDate = nil
                textData.confettiShown = false
                showContinue = false
                
                speechManager.stopSpeakingText()
                
                isEditing = true
            }
        } message: {
            Text("Editing the text will reset the progress.")
        }
    }
    
    private func saveDailyStats() {
        let today = Calendar.current.startOfDay(for: Date())
        let timeToAdd = speechManager.totalPlayTime

        guard timeToAdd > 0 else { return }

        if let existingStats = dailyStats.first(where: { Calendar.current.isDate($0.date, inSameDayAs: today) }) {
            existingStats.timeSpentReading += timeToAdd
        } else {
            let newDailyStats = DailyStats(date: today, timeSpentReading: timeToAdd)
            modelContext.insert(newDailyStats)
        }

        do {
            try modelContext.save()
        } catch {
            print("Failed to save daily stats: \(error)")
        }
    }
    
    func verifyText(text: String) -> Bool {
        if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        
        return true
    }
}

extension AddNewTextView {
    @ViewBuilder
    var BottomPlayerPanel: some View {
        VStack(spacing: 0) {
            HStack {
                if speechManager.speechState == .speaking || speechManager.speechState == .paused {
                    Button(action: {
                        if speechManager.speechState == .paused {
                            speechManager.continueSpeaking()
                        } else {
                            speechManager.pauseSpeaking()
                        }
                        
                    }, label: {
                        Image(systemName: speechManager.speechState == .speaking ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                    })
                    
                } else {
                    Button(action: {
                        addNewTextVM.isVoiceSelectorPresented.toggle()
                        
                    }, label: {
                        Image(selectedVoiceFlagIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        
                    })
                }
                
                Spacer()
                
                if showContinue {
                    Button {
                        speechManager.play(text: textData.text, voice: selectedVoiceIdentifier, from: textData.progress)
                        showContinue = false
                    } label: {
                        VStack(spacing: 0) {
                            Image(systemName: "arrow.right.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(Color.accentColor)
                            
                            Text("Continue")
                                .font(NotoFont.Regular(10))
                        }
                    }
                    Spacer()
                }

                Button {
                    withAnimation {
                        if verifyText(text: textData.text) {
                            if speechManager.speechState == .speaking || speechManager.speechState == .paused {
                                speechManager.stopSpeakingText()
                            } else {
                                speechManager.play(text: textData.text, voice: selectedVoiceIdentifier)
                            }
                        } else {
                            showAlertNoText = true
                        }
                        
                        showContinue = false
                    }
                } label: {
                    Image(systemName: speechManager.speechState == .speaking || speechManager.speechState
                        == .paused ? "stop.circle.fill" : "play.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 55, height: 55)
                        .foregroundColor(speechManager.speechState == .speaking || speechManager.speechState
                            == .paused ? .red : .blue)
                        .clipShape(Circle())
                }
                
                if showContinue {
                    Spacer()
                    Spacer()
                }
                
                Spacer()
                
                Button(action: {
                    addNewTextVM.isVoiceSpeedSelectorPresented = true
                    
                }, label: {
                    Image(systemName: "gear.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                    
                })
                .disabled(speechManager.speechState == .speaking || speechManager.speechState
                    == .paused)
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
        
        .sheet(isPresented: $addNewTextVM.isVoiceSelectorPresented, content: {
            VoiceSelectorView()
                .presentationCompactAdaptation(.automatic)
        })
        .sheet(isPresented: $addNewTextVM.isVoiceSpeedSelectorPresented, content: {
            SettingsView()
            
        })
    }
}

#Preview {
    NavigationStack {
        AddNewTextView(textData: TextDataPreviewProvider.textData1, isEditing: true, isFocused: false, isSaved: false, showTabView: .constant(false))
    }
}
