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
    
    // @Environment(AddNewTextViewModel.self) var addNewTextVM
    @Bindable var addNewTextVM: AddNewTextViewModel
    
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
            // TextFileds for title and Contents
            VStack {
                Divider()
                HStack {
                    Text("Title:")
                        .font(.custom(Constants.Fonts.NotoSerifR, size: 18))
                    TextField("", text: $addNewTextVM.title ?? "")
                        .font(.custom(Constants.Fonts.NotoSerifR, size: 18))
                }
                .scrollContentBackground(.hidden)
                
                .padding(.horizontal, 5)
                
                Divider()
                
                Text("Add Text Below")
                
                
                TextView(text: $addNewTextVM.text ?? "", highlightedRange: $speechManager.highlightedRange) { startIndex in
                    if let text = addNewTextVM.text {
                        speechManager.play(text: text, voice: voice, from: startIndex)
                    }
                }
            }
            
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
                    
                    Button(action: {}, label: {
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
                .padding(8)
            }
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
                
                    Button(role: .destructive) {
                        addNewTextVM.text = ""
                    } label: {
                        Image(systemName: "delete.backward")
                            .foregroundStyle(Color.red)
                    }
                }
            }
            
        })
        .toolbar(content: {
            ToolbarItemGroup(placement: .topBarTrailing) {
                HStack {
                    Button(role: .none) {
                        if let pasteString = addNewTextVM.pasteboard.string {
                            addNewTextVM.text = pasteString
                        }

                    } label: {
                        Image(systemName: "list.clipboard")
                    }
                    
                    if let text = addNewTextVM.text {
                        Button {
                            if verifyText(text: text) {
                                DataCoordinator.shared.saveObject(text: text, title: addNewTextVM.title, textSource: textSource)

                                dismiss()
                            }
                            
                        } label: {
                            Image(systemName: "square.and.arrow.down")
                            
                                .grayscale(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 1 : 0)
                        }
                        .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? true : false)
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
