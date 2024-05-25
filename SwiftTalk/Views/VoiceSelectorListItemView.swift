//
//  VoiceSelectorListItemView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 12/04/24.
//

import SwiftUI

struct VoiceSelectorListItemView: View {
    var voice: Voice
    
    @AppStorage("selectedVoice") var selectedVoice = "Trinoids"
    @AppStorage("language") var language = "en-US"
    
    @State var moveAround = false
    
    var body: some View {
        HStack {
            Image(voice.flagName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
            
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
            
            ZStack {
                Circle()
                    .phaseAnimator([false, true]) { _, moveAround in
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round, miterLimit: 0, dash: [1, 3], dashPhase: moveAround ? -10 : 150))
                            .frame(width: 26, height: 26)
                            .foregroundStyle(.linearGradient(colors: [.red, .green], startPoint: .topLeading, endPoint: .bottomTrailing))
                    } animation: { _ in
                        .linear.speed(0.05).repeatForever(autoreverses: false)
                    }

                Image(systemName: "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
                    .clipShape(Circle())
            }
            
            Text(voice.voiceName)
                .font(.custom(Constants.Fonts.NotoSerifR, size: 14))
            
            Spacer()
            
            Image(systemName: selectedVoice == voice.voiceName ? "checkmark.circle.fill" : "circle.fill")
                .foregroundStyle(selectedVoice == voice.voiceName ? Color.green : Color.secondary)
                .onTapGesture {
                    selectedVoice = voice.voiceName
                    language = voice.languageCode
                }
        }
    }
}

#Preview {
    VoiceSelectorListItemView(voice: Voice(languageCode: "ar-001", voiceName: "Majed", flagName: "saudi-arabia-flag-round-circle-icon", country: "Saudi Arabia", language: "AR"))
}
