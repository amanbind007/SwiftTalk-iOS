//
//  TextFromLinkSheetView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 13/04/24.
//

import SwiftUI

struct WebLinkTextSheetView: View {
    @Binding var addNewTextOptionsVM: AddNewTextOptionsViewModel
    @Binding var showAddNewTextOptionsView: Bool
    @Binding var showWebTextSheet: Bool
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("Paste a web address link to get contents of a webpage")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(NotoFont.Regular(12))
                        .padding()
                    
                    TextField("Paste the web link here", text: $addNewTextOptionsVM.link)
                        .font(NotoFont.Regular(14))
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                        .padding([.bottom], 3)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                    if let message = addNewTextOptionsVM.errorMessage {
                        Text(message)
                            .font(NotoFont.Regular(12))
                            .foregroundStyle(Color.red)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.horizontal)
                            .multilineTextAlignment(.center)
                    }
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            if let pasteString = addNewTextOptionsVM.pasteboard.string {
                                addNewTextOptionsVM.link = pasteString
                            }
                        }, label: {
                            Text("Paste")
                                .padding(.horizontal, 45)
                                .padding(.vertical, 3)
                                .font(NotoFont.SemiBold(16))
                                .foregroundColor(.blue)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 2)
                                        .frame(width: 150)
                                )
                        })
                        Spacer()
                        
                        Button(action: {
                            addNewTextOptionsVM.getTextFromLink { success in
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
                                .font(NotoFont.SemiBold(16))
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
                        .font(NotoFont.Regular(12))
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
                        .font(NotoFont.Regular(16))
                    }
                })
                
                if addNewTextOptionsVM.isParsingWebText {
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
        .onAppear {
            addNewTextOptionsVM.errorMessage = nil
            addNewTextOptionsVM.link = ""
        }
    }
}
    
#Preview {
    WebLinkTextSheetView(
        addNewTextOptionsVM: .constant(AddNewTextOptionsViewModel()),
        showAddNewTextOptionsView: .constant(true),
        showWebTextSheet: .constant(true)
    )
}
