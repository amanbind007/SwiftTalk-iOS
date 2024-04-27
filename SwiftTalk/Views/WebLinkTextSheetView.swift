//
//  TextFromLinkSheetView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 13/04/24.
//

import SwiftUI

struct WebLinkTextSheetView: View {
    @State var addNewTextVM = AddNewTextViewModel()
    @Environment(\.dismiss) var dismiss
    
    init(){
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: Constants.Fonts.AbrilFatfaceR, size: 20)!]

        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: Constants.Fonts.AbrilFatfaceR, size: 40)!]
        
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Paste a web address link to get contents of a webpage")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom(Constants.Fonts.NotoSerifR, size: 12))
                    .padding()
                
                TextField("Paste the web link here", text: $addNewTextVM.link)
                    .font(.custom(Constants.Fonts.NotoSerifR, size: 14))
                    .textFieldStyle(.roundedBorder)
                
                    .padding(.horizontal)
                
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
                        print(addNewTextVM.getTextFromLink())
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
    
#Preview {
    WebLinkTextSheetView()
}
