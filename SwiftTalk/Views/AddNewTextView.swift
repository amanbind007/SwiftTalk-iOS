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
    @Environment(\.modelContext) var modelContext
        
    @Environment(\.colorScheme) private var theme
    @Environment(\.dismiss) private var dismiss
    
    var textSource: AddNewTextOption
    
    @State var speechManager = SpeechSynthesizer()
    
    @AppStorage("SelectedVoice") var voice = "Trinoids"
    @AppStorage("selectedVoiceFlag") var selectedVoiceFlagIcon = "usa-flag-round-circle-icon"

    @Bindable var addNewTextVM: AddNewTextViewModel
    
    @State var isEditing: Bool = false
    @State var isFocused: Bool = false
    
    @State var showAlertTextNotSaved: Bool = false
    @State var showAlertNoText: Bool = false
    
    var textData: TextData?
    
    init(textSource: AddNewTextOption, addNewTextVM: AddNewTextViewModel, textData: TextData?) {
        self.addNewTextVM = addNewTextVM
        self.textSource = textSource
        if let textData = textData {
            self.addNewTextVM.text = textData.text
            self.addNewTextVM.title = textData.textTitle
            self.textData = textData
        }
        else {
            addNewTextVM.text = nil
            addNewTextVM.title = nil
        }
    }

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    if isEditing {
                        BannerButton(iconSystemName: "list.clipboard", color: .blue, text: "Paste")

                            .onTapGesture {
                                if let pasteString = addNewTextVM.pasteboard.string {
                                    addNewTextVM.text = pasteString
                                }
                            }
                          
                        if let text = addNewTextVM.text {
                            BannerButton(iconSystemName: "square.and.arrow.down", color: .green, text: "Save")
                                
                                .grayscale(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 1 : 0)
                                .onTapGesture {
                                    if verifyText(text: text) {
                                        DataCoordinator.shared.saveObject(text: text, title: addNewTextVM.title, textSource: textSource)

                                        dismiss()
                                    }
                                }
                                .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? true : false)
                        }
                        
                        BannerButton(iconSystemName: "delete.backward", color: .red, text: "Delete")
                            .onTapGesture {
                                addNewTextVM.text = ""
                            }
                    }
                }
                .padding(.horizontal, 5)
                
                Divider()
                
                TextView(text: $addNewTextVM.text ?? "", highlightedRange: $speechManager.highlightedRange, editing: $isEditing, focused: $isFocused) { startIndex in
                    if let text = addNewTextVM.text {
                        speechManager.play(text: text, voice: voice, from: startIndex)
                    }
                }
                
                Divider()
            }
            
            if !isEditing {
                // Bottom Control Panel
                VStack {
                    HStack {
                        Button(action: {
                            addNewTextVM.isVoiceSelectorPresented.toggle()
                            
                        }, label: {
                            ZStack {
                                RippledCircle()
                                    .fill(
                                        LinearGradient(
                                            colors: [.pink, .blue, .purple],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 55, height: 55)
                                
                                Image(selectedVoiceFlagIcon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 45, height: 45)
                                    .clipShape(Circle())
                            }
                        })
                        
                        .sheet(isPresented: $addNewTextVM.isVoiceSelectorPresented, content: {
                            VoiceSelectorView()
                                .presentationCompactAdaptation(.automatic)
                        })
                        .sheet(isPresented: $addNewTextVM.isVoiceSpeedSelectorPresented, content: {
                            VoiceSpeedPitchSelectorView()
                                .presentationDetents([.height(280)])
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            // Go forward
                        }, label: {
                            Image(systemName: "goforward")
                                .imageScale(.large)
                        })
                        
                        Spacer()
                        
                        Image(systemName: addNewTextVM.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(addNewTextVM.isPlaying ? .red : .blue)
                            .clipShape(Circle())
                            .onTapGesture {
                                withAnimation {
                                    addNewTextVM.isPlaying.toggle()
                                }
                                
                                if let text = addNewTextVM.text {
                                    speechManager.play(text: text, voice: voice)
                                }
                            }
                        
                        Spacer()
                        
                        Button(action: {
                            // Go forward
                        }, label: {
                            Image(systemName: "gobackward")
                                .imageScale(.large)
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            addNewTextVM.isVoiceSpeedSelectorPresented = true
                            
                        }, label: {
                            FlowerCloud()
                                .fill(
                                    .linearGradient(
                                        colors: [.yellow, .green],
                                        startPoint: .top,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 55, height: 55)
                                .overlay {
                                    Text("2.5x")
                                        .font(.title3)
                                        .bold()
                                        .foregroundStyle(Color.black)
                                }
                        })
                    }
                }
            }
        }
        .onChange(of: speechManager.isSpeaking) {
            print("Speech Manager Changed : \(speechManager.isSpeaking)")
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("SwiftTalk")
        .navigationBarBackButtonHidden()
        
        .toolbar(content: {
            ToolbarItemGroup(placement: .topBarLeading) {
                HStack {
                    Button(role: .cancel) {
                        if let textData = textData, let text = addNewTextVM.text {
                            if DataCoordinator.shared.doesObjectExistAndUpdated(id: textData.id, title: addNewTextVM.title, text: addNewTextVM.text!) {
                                DataCoordinator.shared.updateObject(id: textData.id, text: text, title: addNewTextVM.title)
                                dismiss()
                            }
                            
                            else if verifyText(text: addNewTextVM.text!) {
                                showAlertTextNotSaved = true
                            }
                            else {
                                dismiss()
                            }
                        }
                        
                        dismiss()
                        
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                }
            }
            
        })
        .toolbar(content: {
            ToolbarItemGroup(placement: .topBarTrailing) {
                CustomSwitch(iconSystemName: "pencil.line", colorOn: .green, colorOff: .red, text: "Edit", isOn: $isEditing)
                    .onTapGesture {
                        withAnimation(.linear) {
                            isEditing = isEditing ? false : true
                        }
                    }
            }
        })
        
        .alert(isPresented: $showAlertTextNotSaved, content: {
            Alert(
                title: Text("Not Saved"),
                message: Text("Do you want to save this text?"),
                primaryButton: .default(Text("Yes, save it!"),
                                        action: {
                                            DataCoordinator.shared.saveObject(text: addNewTextVM.text!, title: addNewTextVM.title, textSource: textSource)

                                            dismiss()
                                        }),
                secondaryButton: .cancel {
                    dismiss()
                }
            )
        })
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
        AddNewTextView(textSource: .camera, addNewTextVM: AddNewTextViewModel(), textData: nil)
            .modelContainer(for: TextData.self)
    }
}
