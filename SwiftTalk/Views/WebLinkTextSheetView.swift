//
//  TextFromLinkSheetView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 13/04/24.
//

import SwiftUI

struct WebLinkTextSheetView: View {
    @Bindable var addNewTextVM: AddNewTextViewModel
    @Binding var showAddNewTextOptionsView: Bool
    @Binding var showWebTextSheet: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("Paste a web address link to get contents of a webpage")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom(Constants.Fonts.NotoSerifR, size: 12))
                        .padding()
                    
                    TextField("Paste the web link here", text: $addNewTextVM.link)
                        .font(.custom(Constants.Fonts.NotoSerifR, size: 14))
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                        .padding([.bottom], 3)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                    if let message = addNewTextVM.errorMessage {
                        Text(message + " OR incorrect link")
                            .font(.custom(Constants.Fonts.NotoSerifR, size: 12))
                            .foregroundStyle(Color.red)
                            .frame(width: .infinity, alignment: .trailing)
                    }
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            if let pasteString = addNewTextVM.pasteboard.string {
                                addNewTextVM.link = pasteString
                            }
                        }, label: {
                            Text("Paste")
                                .padding(.horizontal, 45)
                                .padding(.vertical, 3)
                                .font(.custom(Constants.Fonts.NotoSerifSB, size: 16))
                                .foregroundColor(.blue)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 2)
                                        .frame(width: 150)
                                )
                        })
                        Spacer()
                        
                        Button(action: {
                            addNewTextVM.getTextFromLink { success in
                                if success {
                                    showWebTextSheet = false
                                    showAddNewTextOptionsView = false
                                } else {
                                    print("Failed to retrieve text.")
                                }
                            }
                        }, label: {
                            Text("Go")
                                .padding(.horizontal, 45)
                                .padding(.vertical, 3)
                                .font(.custom(Constants.Fonts.NotoSerifSB, size: 16))
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 150)
                                )
                        })
                        Spacer()
                    }
                    
                    Text("NOTE: We cannot get the content if the webpage requires a login")
                        .foregroundStyle(Color.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom(Constants.Fonts.NotoSerifR, size: 12))
                        .padding()
                    
                    Spacer()
                }
                .navigationTitle("Paste Web Link")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                        .font(.custom(Constants.Fonts.NotoSerifR, size: 16))
                    }
                })
                
                if addNewTextVM.isParsingWebText {
                    RoundedRectangle(cornerRadius: 0)
                        .frame(width: 2000, height: 2000)
                        .foregroundStyle(Material.thick)
                        .opacity(0.7)
                        .ignoresSafeArea()
                        .overlay {
                            ProgressView()
                                .scaledToFit()
                        }
                }
                Spacer()
            }
        }
    }
}
    
#Preview {
    WebLinkTextSheetView(
        addNewTextVM: AddNewTextViewModel(),
        showAddNewTextOptionsView: .constant(true),
        showWebTextSheet: .constant(true)
    )
}
