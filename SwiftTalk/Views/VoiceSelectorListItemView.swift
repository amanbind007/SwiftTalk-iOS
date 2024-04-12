//
//  VoiceSelectorListItemView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 12/04/24.
//

import SwiftUI

struct VoiceSelectorListItemView: View {
    
    var voice: Voice
    @Binding var selectedVoice: String?
    
    var body: some View {
        HStack {
            Image(voice.flagName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
            
            Divider()
            
            ZStack {
                HexagonShape()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundStyle(
                        LinearGradient(colors: [.indigo, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                
                Text(voice.language)
                    .font(.custom("ChangaOne", size: 14))
                    .foregroundStyle(Color.white)
            }
            
            Divider()
            
            ZStack {
                RippledCircle()
                
                    .fill(LinearGradient(colors: [.pink, .blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 30, height: 30)
                
                Image("myPhoto2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                
                    .clipShape(RippledCircle())
            }
            
            Text(voice.voiceName)
                .font(.custom(Constants.Fonts.NotoSerifR, size: 14))
            
            Spacer()
            
            Image(systemName: selectedVoice == voice.voiceName ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(selectedVoice == voice.voiceName ? Color.green : Color.red)
                .onTapGesture {
                    selectedVoice = voice.voiceName
                }
        }
    }
}

#Preview {
    VoiceSelectorListItemView(voice: Voice(languageCode: "ar-001", voiceName: "Majed", flagName: "saudi-arabia-flag-round-circle-icon", country: "Saudi Arabia", language: "AR"), selectedVoice: .constant("Majed"))
}
