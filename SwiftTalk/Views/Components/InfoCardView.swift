//
//  InfoCardView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 02/08/24.
//

import SwiftUI

struct InfoCardView: View {
    @Binding var isPresented: Bool
    // var textData: TextData?

    var body: some View {
        if isPresented {
            // if let textData = textData, isPresented {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    Text("ImageText 2024-08-04 19.00.22")
                        .font(NotoFont.Bold(16))
                        .padding()
                    
                    
                }
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                    Label("Thu, 25 Jul, 2024 • 1:06 PM", systemImage: "calendar.badge.plus")
                    
                    Text("Details")
                        .font(NotoFont.Bold(16))
                        .padding(.vertical)
                    
                    Label("Estimated completion time: \("1h 36min 59sec")", systemImage: "clock.badge.questionmark")
                        
                    Label("Total time spend: \("36 min 59sec")", systemImage: "clock.badge")
                    
                    //Label("Total character, word, sentences, paragraphs: \()", systemImage: "123.rectangle")
                    
                    Label("Completion Percentage: \(29)%", systemImage: "checkmark.bubble")
                    
                    Label("Remaining Percentage: \(71)%", systemImage: "flag.checkered")
                    
                    Label("Completion Date: \("Thu, 25 Jul, 2024 • 1:06 PM")", systemImage: "calendar.badge.checkmark")
                    
                    Label("Text Source: \("Text Input")", systemImage: "questionmark.diamond")
                }
                .imageScale(.large)
                .font(NotoFont.Regular(14))
                .padding()
            }
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .shadow(radius: 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .toolbar(.hidden, for: .tabBar)
            .background(
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPresented = false
                    }
            )
        }
    }
}

#Preview {
    InfoCardView(isPresented: .constant(true))
}
