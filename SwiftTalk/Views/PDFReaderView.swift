//
//  PDFReaderView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 31/05/25.
//

import SwiftUI
import PDFKit
import SwiftData

struct PDFReaderView: View {
    
    @Environment(\.colorScheme) private var theme
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Query private var dailyStats: [DailyStats]
    
    @State var speechManager: SpeechSynthesizer = .init()
    
    @AppStorage("selectedVoice") var selectedVoiceIdentifier = "com.apple.speech.synthesis.voice.Trinoids"
    @AppStorage("selectedVoiceFlag") var selectedVoiceFlagIcon = "usa"
    @State var showCaption: Bool = true
    
    @State var textData: TextData
    @State var showContinue: Bool
    @State var isFinished: Bool = false
    @State var showConfettiAnimation: Bool = false
    @Binding var showTabView: Bool
    
    init(textData: TextData, showTabView: Binding<Bool>) {
        if textData.progress > 0 && textData.progress < textData.text.count {
            self.showContinue = true
        } else {
            self.showContinue = false
        }
        self.textData = textData
        self._showTabView = showTabView
        
    }
        
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack{
                if let pdfURL = textData.pdfFileURL, let pdfDocument = PDFDocument(url: pdfURL) {
                    PDFViewer(pdfDocument: pdfDocument, currentPage: $textData.currentPage, highlightedRange: $speechManager.highlightedRange, onCharacterTapped: { pageNumber, startIndex in
                        speechManager.play(textData: textData, pageNumber: pageNumber, from: startIndex)
                    })
                } else {
                    Text("No PDF available")
                        .foregroundColor(.red)
                }
                
            }
        }
        .onAppear(perform: {
            showTabView = false
            
            // update access date-time
            textData.lastAccess = Date()
        })
        .onDisappear(perform: {
            showTabView = true
        })
        .onChange(of: speechManager.highlightedRange?.upperBound) {
            if let highlightedRange = speechManager.highlightedRange {
                if textData.progress < highlightedRange.upperBound {
                    textData.progress = highlightedRange.upperBound
                }
                
                if textData.text.count == textData.progress {
                    showConfettiAnimation = true
                    textData.completionDate = Date()
                }
            }
        }
        .onChange(of: speechManager.totalPlayTime) {
            textData.timeSpend += speechManager.totalPlayTime
            saveDailyStats()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("SwiftTalk")
        .navigationBarBackButtonHidden()
        .overlay(
            ConfettiView(textData: $textData, showConfettiAnimation: $showConfettiAnimation)
        )
        
        .toolbar(content: {
            ToolbarItemGroup(placement: .topBarLeading) {
                HStack {
                    Button(role: .cancel) {
                        
                        speechManager.stopSpeakingText()
                        dismiss()
                        
                    } label: {
                        BannerButton(iconSystemName: "chevron.left", color: .accentColor, text: "")
                    }
                }
            }
            
        })
    }
    
    
    
    private func saveDailyStats() {
        let today = Calendar.current.startOfDay(for: Date())
        let timeToAdd = speechManager.totalPlayTime

        guard timeToAdd > 0 else { return }

        if let existingStats = dailyStats.first(where: { Calendar.current.isDate($0.date, inSameDayAs: today) }) {
            existingStats.timeSpentReading += timeToAdd
        } else {
            let newDailyStats = DailyStats(date: today, timeSpentReading: timeToAdd)
            modelContext.insert(newDailyStats)
        }

        do {
            try modelContext.save()
        } catch {
            print("Failed to save daily stats: \(error)")
        }
    }
                        
}

#Preview {
    NavigationStack{
        PDFReaderView(textData: TextDataPreviewProvider.textData5, showTabView: .constant(false))
    }
}
            
    
    


