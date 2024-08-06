//
//  InfoCardView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 02/08/24.
//

import SwiftUI

struct InfoCardView: View {
    @Binding var isPresented: Bool
    var textData: TextData?

    var body: some View {
        if let textData = textData, isPresented {
            VStack(spacing: 0) {
                ZStack {
                    Color.gradiantColor1
                    Text(textData.textTitle!)
                        .font(NotoFont.Bold(16))
                        .padding()
                }
                .frame(height: 55)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                    Label(textData.creationDateString, systemImage: "calendar.badge.plus")
                    
                    Divider()
                    
                    Text("Details")
                        .font(NotoFont.Bold(16))
                        .padding(.vertical)
                    
                    Label("Estimated completion time: \(textData.estimateReadTime)", systemImage: "clock.badge.questionmark")
                        
                    Label("Total time spend: \(textData.timeSpendString)", systemImage: "clock.badge")
                    
                    // Label("Total character, word, sentences, paragraphs: \()", systemImage: "123.rectangle")
                    
                    Label("Completion Percentage: \(textData.progressPercentage)%", systemImage: "checkmark.bubble")
                    
                    Label("Remaining Percentage: \(100.00 - textData.progressPercentage)%", systemImage: "flag.checkered")
                    
                    if let completionDateString = textData.completionDateString {
                        Label("Completion Date: \(completionDateString)", systemImage: "calendar.badge.checkmark")
                    }
                    
                    Label("Text Source: \(textData.textSource.title)", systemImage: "questionmark.diamond")
                }
                .imageScale(.large)
                .font(NotoFont.Regular(14))
                .padding()
            }
            .background(Material.ultraThick)
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
    InfoCardView(isPresented: .constant(true), textData: TextDataPreviewProvider.textData1)
}
