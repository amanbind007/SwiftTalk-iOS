//
//  VoiceSelectorListItemView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 12/04/24.
//

import AVFoundation
import SwiftUI

struct VoiceSelectorListItemView: View {
    var voice: Voice

    @Environment(\.dismiss) var dismiss
    @AppStorage("selectedVoice") var selectedVoiceIdentifier = "com.apple.speech.synthesis.voice.Samantha"
    @AppStorage("selectedVoiceFlag") var selectedVoiceFlagIcon = "usa"

    @State var isPlaying = false
    @Binding var speechManager: SpeechSynthesizer

    var body: some View {
        HStack {
            Button {
                selectedVoiceIdentifier = voice.identifier
                selectedVoiceFlagIcon = voice.flag
                dismiss()

            } label: {
                Image(systemName: selectedVoiceIdentifier == voice.identifier ? "checkmark.circle.fill" : "circle.fill")
                    .foregroundStyle(selectedVoiceIdentifier == voice.identifier ? Color.green : Color.secondary)

                    .imageScale(.large)
            }

            Divider()
            Image(voice.flag)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 26, height: 26)

            Divider()

            Text("\(voice.trimmedName) (\(voice.gender))") { string in

                if let range = string.range(of: "(\(voice.gender))") {
                    string[range].foregroundColor = .secondary
                }
            }
            .font(NotoFont.Regular(15))

            if voice.voiceName.contains("(Enhanced)") {
                Image(uiImage: UIImage.eStar)
                    .resizable()
                    .frame(width: 26, height: 26)
            }

            if voice.voiceName.contains("(Premium)") {
                Image(uiImage: UIImage.pStar)
                    .resizable()
                    .frame(width: 26, height: 26)
            }

            Spacer()

            Image(systemName: speechManager.speechState == .speaking && speechManager.currentlyPlayingVoice == voice.identifier ? "stop.circle.fill" : "play.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .clipShape(Circle())
                .foregroundStyle(speechManager.speechState == .speaking && speechManager.currentlyPlayingVoice == voice.identifier ? .red : .blue)
                .onTapGesture {
                    if speechManager.speechState == .speaking {
                        speechManager.stopDemo()
                    } else {
                        speechManager.playDemo(text: voice.demoText, identifier: voice.identifier)
                    }
                }
        }
    }
}

#Preview {
    VoiceSelectorListItemView(
        voice: Voice(languageCode: "ar-001", voiceName: "Majed", country: "world", language: "Arabic", demoText: "مرحبا، أنا صوتك الناطق الجديد. كيف أبدو ؟", identifier: "com.apple.voice.compact.ar-001.Maged", gender: "Female", flag: "world"),
        speechManager: .constant(SpeechSynthesizer())
    )
}
