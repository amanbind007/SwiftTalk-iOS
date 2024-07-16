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
    
    @State var speechManager: SpeechSynthesizer = .init()
    
    @AppStorage("selectedVoice") var selectedVoiceIdentifier = "com.apple.speech.synthesis.voice.Trinoids"
    @AppStorage("selectedVoiceFlag") var selectedVoiceFlagIcon = "usa"

    @State var addNewTextVM: AddNewTextViewModel = .init()
    @State var textData: TextData
    @State var isEditing: Bool = false
    @State var isFocused: Bool = false
    
    @State var showAlertTextNotSaved: Bool = false
    @State var showAlertNoText: Bool = false
    
    @State var isSaved: Bool
    
    @State var showContinue: Bool
    
    init(textData: TextData, isEditing: Bool, isFocused: Bool, isSaved: Bool) {
        self.textData = textData
        self.isEditing = isEditing
        self.isFocused = isFocused
        self.isSaved = isSaved
        
        if textData.progress > 0 && textData.progress < textData.text.count {
            self.showContinue = true
        } else {
            self.showContinue = false
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                if isEditing {
                    HStack {
                        if !isSaved {
                            Button {
                                if verifyText(text: textData.text) {
                                    DataCoordinator().saveObject(text: textData.text, title: nil, textSource: textData.textSource)
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
                
                if speechManager.speechState == .speaking || speechManager.speechState == .paused {
                    LinearProgressBar(value: speechManager.currentCompletedIndex + speechManager.startIndex, total: textData.text.count, color: textData.textSource.color)
                        .frame(height: 12)
                }
                
                GeometryReader { proxy in
                    TextView(text: $textData.text, highlightedRange: $speechManager.highlightedRange, editing: $isEditing, focused: $isFocused) { startIndex in
                        if !isEditing {
                            speechManager.play(text: textData.text, voice: selectedVoiceIdentifier, from: startIndex)
                        }
                    }
                    .frame(width: proxy.size.width, height: proxy.size.height)
                }
                    
                Divider()
            }
            
            if !isEditing {
                // Bottom Control Panel
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
                                        .font(.custom(Constants.Fonts.NotoSerifR, size: 10))
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
        .onChange(of: speechManager.highlightedRange?.upperBound) {
            if let highlightedRange = speechManager.highlightedRange {
                if textData.progress < highlightedRange.upperBound {
                    textData.progress = highlightedRange.upperBound
                }
            }
        }
        .onChange(of: speechManager.totalPlayTime) {
            textData.timeSpend += speechManager.totalPlayTime
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("SwiftTalk")
        .navigationBarBackButtonHidden()
        
        .toolbar(content: {
            ToolbarItemGroup(placement: .topBarLeading) {
                HStack {
                    Button(role: .cancel) {
                        if !isSaved && verifyText(text: textData.text) {
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
                CustomSwitch(iconSystemName: "pencil.line", colorOn: .green, colorOff: .red, text: "Edit", isOn: $isEditing)
                    .onTapGesture {
                        withAnimation(.linear) {
                            isEditing = isEditing ? false : true
                            if isEditing {
                                speechManager.stopSpeakingText()
                            }
                        }
                    }
            }
        })
        .alert(isPresented: $showAlertNoText, content: {
            Alert(
                title: Text("No Text"),
                message: Text("Add some text to read/save out")
            )
        })
        
//        .onChange(of: speechManager.highlightedRange?.upperBound) {
//            print("Current Index: \(speechManager.highlightedRange?.upperBound)")
//        }
    }
    
    func verifyText(text: String) -> Bool {
        if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        
        return true
    }
    
}

#Preview {
    NavigationStack {
        AddNewTextView(textData: TextDataPreviewProvider.textData1, isEditing: true, isFocused: false, isSaved: false)
    }
}
