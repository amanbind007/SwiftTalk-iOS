//
//  AddNewTextOptionsView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 11/03/24.
//

import SwiftUI

struct AddNewTextOptionsView: View {
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    ScrollView {
                        HStack {
                            Image(Constants.Icons.cameraIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                            
                            VStack(alignment: .leading) {
                                Text("Camera Scan")
                                    .underline()
                                    .font(.custom(Constants.Fonts.NotoSerifSB, size: 14))
                                
                                Text("Scan physical text using your camera")
                                    .font(.custom(Constants.Fonts.NotoSerifR, size: 13))
                                    .lineSpacing(0.1)
                            }
                            Spacer()
                        }
                        .padding(10)
                        .background(Color.accent1)
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                        .padding([.horizontal], 8)
                        .padding([.top], 52)
                        
                        HStack {
                            Image(Constants.Icons.imageFileIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                            
                            VStack(alignment: .leading) {
                                Text("Photo Library")
                                    .underline()
                                    .font(.custom(Constants.Fonts.NotoSerifSB, size: 14))
                                
                                Text("Get text from the photos in you library")
                                    .font(.custom(Constants.Fonts.NotoSerifR, size: 13))
                                    .lineSpacing(0.1)
                            }
                            Spacer()
                        }
                        .padding(10)
                        .background(Color.accent1)
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                        .padding(.horizontal, 8)
                        
                        HStack {
                            Image(Constants.Icons.wordFileIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                            
                            VStack(alignment: .leading) {
                                Text("Word Documents")
                                    .underline()
                                    .font(.custom(Constants.Fonts.NotoSerifSB, size: 14))
                                
                                Text("Add documents from your local storage or cloud")
                                    .font(.custom(Constants.Fonts.NotoSerifR, size: 13))
                            }
                            Spacer()
                        }
                        .padding(10)
                        .background(Color.accent1)
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                        .padding(.horizontal, 8)
                        
                        HStack {
                            Image(Constants.Icons.textFileInputIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                            
                            VStack(alignment: .leading) {
                                Text("Text")
                                    .underline()
                                    .font(.custom(Constants.Fonts.NotoSerifSB, size: 14))
                                
                                Text("Input or paste text to read")
                                    .font(.custom(Constants.Fonts.NotoSerifR, size: 13))
                            }
                            Spacer()
                        }
                        .padding(10)
                        .background(Color.accent1)
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                        .padding(.horizontal, 8)
                        
                        HStack {
                            Image(Constants.Icons.pdfFileIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                            
                            VStack(alignment: .leading) {
                                Text("PDF Documents")
                                    .underline()
                                    .font(.custom(Constants.Fonts.NotoSerifSB, size: 14))
                                
                                Text("Add PDFs from your local storage or cloud")
                                    .font(.custom(Constants.Fonts.NotoSerifR, size: 13))
                            }
                            Spacer()
                        }
                        .padding(10)
                        .background(Color.accent1)
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                        .padding(.horizontal, 8)
                        
                        HStack {
                            Image(Constants.Icons.webIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                            
                            VStack(alignment: .leading) {
                                Text("Webpage")
                                    .underline()
                                    .font(.custom(Constants.Fonts.NotoSerifSB, size: 14))
                                
                                Text("Listen to the contents of a webpage")
                                    .font(.custom(Constants.Fonts.NotoSerifR, size: 13))
                            }
                            Spacer()
                        }
                        .padding(10)
                        .background(Color.accent1)
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                        .padding(.horizontal, 8)
                        
                        Spacer()
                    }
                    .background(
                        Color.accent2
                    )
                }
                
                VStack {
                    VStack {
                        HStack {
                            Text("Add Text")
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
}

#Preview {
    AddNewTextOptionsView()
}
