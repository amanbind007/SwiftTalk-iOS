//
//  NewTextView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 08/03/24.
//

import AVFoundation
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

    var body: some View {
        VStack {
            // TextFileds for title and Contents
            VStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(
                        LinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing)
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
                        LinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing)
                    )
//                if addNewTextVM.isPlaying {
//                    VStack(alignment: .leading) {
//                        ScrollView {
//                            Text(addNewTextVM.text)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                                .font(.custom(Constants.Fonts.NotoSerifR, size: 18))
//                        }
//                    }
//                    .padding(.horizontal, 5)
//                    .padding(.top, 8)
//
//                } else {
                TextEditor(text: $addNewTextVM.text)
                    .font(.custom(Constants.Fonts.NotoSerifR, size: 18))
                
//                }
            }
            
            // Bottom Control Panel
            VStack {
                HStack {
                    Button(action: {
                        addNewTextVM.isVoiceSelectorPresented.toggle()
                        
                    }, label: {
                        ZStack {
                            RippledCircle()
                                .fill(LinearGradient(colors: [.pink, .blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 55, height: 55)
                                .rotationEffect(.degrees(addNewTextVM.degreesRotating))
                                .onAppear(perform: {
                                    withAnimation(.linear(duration: 1)
                                        .speed(0.5).repeatForever(autoreverses: false))
                                    {
                                        addNewTextVM.degreesRotating = 360.0
                                    }
                                    
                                })
                                
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
                            
                            speechManager.play(text: addNewTextVM.text, voice: voice)
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
                                .linearGradient(colors: [.yellow, .green], startPoint: .top, endPoint: .bottomTrailing)
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
            ToolbarItem(placement: .topBarLeading) {
                Button(role: .cancel) {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button(role: .destructive) {
                    addNewTextVM.text = ""
                } label: {
                    Image(systemName: "delete.backward")
                        .foregroundStyle(Color.red)
                }
            }
            
            ToolbarItemGroup {
                HStack {
                    Button(role: .none) {
                        if let pasteString = addNewTextVM.pasteboard.string {
                            addNewTextVM.text = pasteString
                        }
                        
                    } label: {
                        Image(systemName: "list.clipboard")
                    }
                    
                    Button {
                        // Save the text in persistence storage and dismiss View if title is present
                        
                        if let text = addNewTextVM.text {
                            if verifyText(text: text) {
                                let textData = TextData(textTitle: addNewTextVM.title, text: text, textSource: textSource, iconType: textSource.imageName, dateTime: Date().timeIntervalSince1970)
                                modelContext.save()
                                dismiss()
                            }
                        }
                        
                           
                        
                    } label: {
                        Image(systemName: "square.and.arrow.down")
                            
                            .grayscale(addNewTextVM.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 1 : 0)
                    }
                    .disabled(addNewTextVM.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? true : false)
                }
            }
            
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
        AddNewTextView(textSource: .textInput, addNewTextVM: AddNewTextViewModel())
    }
}
