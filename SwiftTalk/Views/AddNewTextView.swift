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
    
    var speechManager = SpeechSynthesizer()
    
    @AppStorage("SelectedVoice") var voice = "Trinoids"
    
    // @Environment(AddNewTextViewModel.self) var addNewTextVM
    @Bindable var addNewTextVM: AddNewTextViewModel
    
    @State var showAlertTextNotSaved: Bool = false
    @State var showAlertNoText: Bool = false
    
    init(textSource: AddNewTextOption, addNewTextVM: AddNewTextViewModel, text: String?, title: String?) {
        if let text = text {
            addNewTextVM.text = text
        }
        if let title = title {
            addNewTextVM.title = title
        }
        self.addNewTextVM = addNewTextVM
        self.textSource = textSource
    }

    var body: some View {
        VStack {
            // TextFileds for title and Contents
            VStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.pink, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                HStack {
                    Text("Title:")
                        .font(.custom(Constants.Fonts.NotoSerifR, size: 18))
                    TextField("", text: $addNewTextVM.title ?? "")
                        .font(.custom(Constants.Fonts.NotoSerifR, size: 18))
                }
                .scrollContentBackground(.hidden)
                
                .padding(.horizontal, 5)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.pink, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                TextEditor(text: $addNewTextVM.text ?? "")
                    .font(.custom(Constants.Fonts.NotoSerifR, size: 18))
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

                            Image("myPhoto2")
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
                        if let text = addNewTextVM.text {
                            if verifyText(text: text) {
                                showAlertTextNotSaved = true
                            }
                        }
                        else{
                            dismiss()
                        }
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
                            // Save the text in persistence storage and dismiss View if title is present
                            if verifyText(text: text) {
                                let textData = TextData(textTitle: addNewTextVM.title, text: text, textSource: textSource, iconType: textSource.imageName, dateTime: Date().timeIntervalSince1970)
                                do {
                                    modelContext.insert(textData)
                                    try modelContext.save()
                                    dismiss()
                                } catch {
                                    print(error)
                                    dismiss()
                                }
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
                                            let textData = TextData(
                                                textTitle: addNewTextVM.title,
                                                text: addNewTextVM.text!,
                                                textSource: textSource,
                                                iconType: textSource.imageName,
                                                dateTime: Date().timeIntervalSince1970
                                            )
                                            do {
                                                modelContext.insert(textData)
                                                try modelContext.save()
                                                dismiss()
                                            } catch {
                                                print(error)
                                                dismiss()
                                            }
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
        AddNewTextView(textSource: .camera, addNewTextVM: AddNewTextViewModel(), text: "Hello", title: "world")
            .modelContainer(for: TextData.self)
    }
}
