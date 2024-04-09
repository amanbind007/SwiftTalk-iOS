//
//  NewTextView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 08/03/24.
//

import AVFoundation
import SwiftUI

struct AddNewTextView: View {
    @Environment(\.colorScheme) private var theme
    @Environment(\.dismiss) private var dismiss
    
    @State var addNewTextVM = AddNewTextViewModel()

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
                    TextField("", text: $addNewTextVM.title)
                        .font(.custom(Constants.Fonts.NotoSerifR, size: 18))
                }
                .scrollContentBackground(.hidden)
                
                .padding(.horizontal, 5)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(
                        LinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing)
                    )
                TextEditor(text: $addNewTextVM.text)
                    .font(.custom(Constants.Fonts.NotoSerifR, size: 18))
            }
            
            // Bottom Control Panel
            VStack {
                HStack {
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
                            .onTapGesture {
                                addNewTextVM.isPopoverPresented.toggle()
                            }
                        
                        Image("myPhoto2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45, height: 45)
                            .clipShape(Circle())
                            .onTapGesture {
                                addNewTextVM.isPopoverPresented.toggle()
                            }
                    }
                    .popover(isPresented: $addNewTextVM.isPopoverPresented, content: {
                        VoiceSelectorView()
                            .presentationCompactAdaptation(.automatic)
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
                        }
                    
                    Spacer()
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
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            }
            
            ToolbarItemGroup {
                HStack {
                    Button(role: .destructive) {
                        addNewTextVM.text = ""
                    } label: {
                        Image(Constants.Icons.backspaceicon)
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    
                    Button(role: .none) {
                        if let pasteString = addNewTextVM.pasteboard.string {
                            addNewTextVM.text = pasteString
                        }
                        
                    } label: {
                        Image(Constants.Icons.clipboardIcon)
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    
                    Button {
                        // Save the text in persistence storage and dismiss View
                        
                        dismiss()
                    } label: {
                        
                        Image(Constants.Icons.saveIcon)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .grayscale(addNewTextVM.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 1 : 0)
                            
                    }
                    .disabled(addNewTextVM.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? true : false)
                }
            }
            
        })
    }
}

#Preview {
    NavigationStack {
        AddNewTextView()
    }
}
