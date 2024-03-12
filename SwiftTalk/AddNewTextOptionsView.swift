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
            VStack {
                HStack {
                    Text("Add Text")
                        .font(.custom("AbrilFatface-Regular", size: 20))
                        .offset(y: 10)
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(
                        LinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing)
                    )

            }
            
            ScrollView{
                
                HStack {
                    Image("camera_file")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    
                    VStack(alignment: .leading) {
                        Text("Camera Scan")
                            .underline()
                            .font(.custom("NotoSerif-SemiBold", size: 14))
                        
                        Text("Scan physical text using your camera")
                            .font(.custom("NotoSerif-Regular", size: 13))
                            .lineSpacing(0.1)
                    }
                    Spacer()
                }
                .padding(10)
                .background(Color.teal)
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                .padding(.horizontal, 8)
                
                HStack {
                    Image("image_file")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    
                    VStack(alignment: .leading) {
                        Text("Photo Library")
                            .underline()
                            .font(.custom("NotoSerif-SemiBold", size: 14))
                        
                        Text("Get text from the photos in you library")
                            .font(.custom("NotoSerif-Regular", size: 13))
                            .lineSpacing(0.1)
                    }
                    Spacer()
                }
                .padding(10)
                .background(Color.teal)
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                .padding(.horizontal, 8)
                
                HStack {
                    Image("word_file")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    
                    VStack(alignment: .leading) {
                        Text("Word Documents")
                            .underline()
                            .font(.custom("NotoSerif-SemiBold", size: 14))
                        
                        Text("Add documents from your local storage or cloud")
                            .font(.custom("NotoSerif-Regular", size: 13))
                    }
                    Spacer()
                }
                .padding(10)
                .background(Color.teal)
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                .padding(.horizontal, 8)
                
                HStack {
                    Image("text_input_file")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    
                    VStack(alignment: .leading) {
                        Text("Text")
                            .underline()
                            .font(.custom("NotoSerif-SemiBold", size: 14))
                        
                        Text("Input or paste text to read")
                            .font(.custom("NotoSerif-Regular", size: 13))
                    }
                    Spacer()
                }
                .padding(10)
                .background(Color.teal)
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                .padding(.horizontal, 8)
                
                HStack {
                    Image("pdf_file")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    
                    VStack(alignment: .leading) {
                        Text("PDF Documents")
                            .underline()
                            .font(.custom("NotoSerif-SemiBold", size: 14))
                        
                        Text("Add PDFs from your local storage or cloud")
                            .font(.custom("NotoSerif-Regular", size: 13))
                    }
                    Spacer()
                }
                .padding(10)
                .background(Color.teal)
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                .padding(.horizontal, 8)
                
                HStack {
                    Image("web_file")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                    
                    VStack(alignment: .leading) {
                        Text("Webpage")
                            .underline()
                            .font(.custom("NotoSerif-SemiBold", size: 14))
                        
                        Text("Listen to the contents of a webpage")
                            .font(.custom("NotoSerif-Regular", size: 13))
                    }
                    Spacer()
                }
                .padding(10)
                .background(Color.teal)
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                .padding(.horizontal, 8)
                
                Spacer()
                
            }
        }
    }
}

#Preview {
    AddNewTextOptionsView()
}
