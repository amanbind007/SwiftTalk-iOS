//
//  AddNewTextOptionsView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 11/03/24.
//

import SwiftUI

struct AddNewTextOptionsView: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                // List of Options for adding text
                ScrollView {
                    NavigationLink {
                        
                        //AddNewTextView()
                            
                                
                    } label: {
                        AddNewTextOptionCardView(title: "Camera Scan", description: "Scan physical text using your camera", imageName: Constants.Icons.cameraIcon)
                            .padding([.top], 52)
                    }
                    
                    NavigationLink {
                        //AddNewTextView()
                                
                    } label: {
                        AddNewTextOptionCardView(title: "Photo Library", description: "Get text from the photos in you library", imageName: Constants.Icons.imageFileIcon)
                    }
                    
                    NavigationLink {
                        //AddNewTextView()
                                
                    } label: {
                        AddNewTextOptionCardView(title: "Word Documents", description: "Add documents from your local storage or cloud", imageName: Constants.Icons.wordFileIcon)
                    }
                    
                    NavigationLink {
                        AddNewTextView()
                                
                    } label: {
                        AddNewTextOptionCardView(title: "Text", description: "Input or paste text to read", imageName: Constants.Icons.textFileInputIcon)
                    }
                    
                    NavigationLink {
                        //AddNewTextView()
                                
                    } label: {
                        AddNewTextOptionCardView(title: "PDF Documents", description: "Add PDFs from your local storage or cloud", imageName: Constants.Icons.pdfFileIcon)
                    }
                    
                    NavigationLink {
                        //AddNewTextView()
                                
                    } label: {
                        AddNewTextOptionCardView(title: "Webpage", description: "Listen to the contents of a webpage", imageName: Constants.Icons.webIcon)
                    }

                    Spacer()
                }
                .background(
                    Color.accent2
                )
                
                // Custom Top Bar View
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
