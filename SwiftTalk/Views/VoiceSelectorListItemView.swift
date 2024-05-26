//
//  VoiceSelectorListItemView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 12/04/24.
//

import SwiftUI
import AVFoundation

struct VoiceSelectorListItemView: View {
    var voice: Voice
    
    @AppStorage("selectedVoice") var selectedVoice = "Trinoids"
    @AppStorage("language") var language = "en-US"
    
    @State var play = false
    
    var body: some View {
        HStack {
            Image(systemName: selectedVoice == voice.voiceName ? "checkmark.circle.fill" : "circle.fill")
                .foregroundStyle(selectedVoice == voice.voiceName ? Color.green : Color.secondary)
                .onTapGesture {
                    selectedVoice = voice.voiceName
                    language = voice.languageCode
                }
                .imageScale(.large)
            Divider()
            Image(voice.flagName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 26, height: 26)
            
            Divider()
            
            ZStack {
                Text(voice.language)
                    .font(.custom("ChangaOne", size: 14))
                    .foregroundStyle(Color.white)
                    .padding(5)
                    .overlay {
                        HexagonShape()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(
                                LinearGradient(colors: [.indigo, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    }
            }
            
            Divider()
            
            Text(voice.voiceName)
                .font(.custom(Constants.Fonts.NotoSerifR, size: 14))
            
            Spacer()
            
            Button(action: {
                play.toggle()
                if play {
                    playDemoVoice(voice: voice)
                }
            }, label: {
                ZStack {
                    Image(systemName: play ? "stop.circle.fill" : "play.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .clipShape(Circle())
                        .foregroundStyle(play ? .red : .blue)
                }
            })
        }
    }
    
    func playDemoVoice(voice: Voice){
        let synthesizer = AVSpeechSynthesizer()
        let utterrence = AVSpeechUtterance(string: voice.demoText)
        utterrence.voice = AVSpeechSynthesisVoice(language: voice.languageCode)

        synthesizer.speak(utterrence)
        synthesizer.pauseSpeaking(at: .immediate)
    }
    
    
}

#Preview {
    VoiceSelectorListItemView(voice: Voice(languageCode: "ar-001", voiceName: "Majed", flagName: "saudi-arabia-flag-round-circle-icon", country: "Saudi Arabia", language: "AR", demoText: "مرحبا بالعالم! هذا هو صوت م أجِد لتجربة ميزة تحويل النص إلى كلام"))
}
