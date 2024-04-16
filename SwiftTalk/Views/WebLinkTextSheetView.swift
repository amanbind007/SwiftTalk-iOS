//
//  TextFromLinkSheetView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 13/04/24.
//

import SwiftUI

struct WebLinkTextSheetView: View {
    @State var link: String = ""
    
    let pasteboard = UIPasteboard.general
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Paste a web address link to get contents of a webpage")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom(Constants.Fonts.NotoSerifR, size: 12))
                    .padding()
                
                TextField("Paste the web link here", text: $link)
                    .font(.custom(Constants.Fonts.NotoSerifR, size: 14))
                    .textFieldStyle(.roundedBorder)
                
                    .padding(.horizontal)
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        if let pasteString = pasteboard.string {
                            link = pasteString
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
                    
                    Button(action: {}, label: {
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
            }
            
            VStack {
                VStack {
                    HStack {
                        Text("Paste Web Link")
                            .font(.custom(Constants.Fonts.AbrilFatfaceR, size: 20))
                            .offset(y: 10)
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(
                            LinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing)
                        )
                }
                .background(Material.ultraThin)
                
                Spacer()
            }
        }
    }
}

#Preview {
    WebLinkTextSheetView()
}
