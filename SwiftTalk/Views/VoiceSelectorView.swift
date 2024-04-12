//
//  VoiceSelectorView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 14/03/24.
//

import SwiftUI

struct VoiceSelectorView: View {
    @State var selectedVoice: String?
    
    let voices: [Voice] = [
        Voice(languageCode: "ar-001", voiceName: "Majed", flagName: "saudi-arabia-flag-round-circle-icon", country: "Saudi Arabia", language: "AR"),
        Voice(languageCode: "bg-BG", voiceName: "Daria", flagName: "bulgaria-flag-round-circle-icon", country: "Bulgaria", language: "BG"),
        Voice(languageCode: "ca-ES", voiceName: "Montse", flagName: "spain-country-flag-round-icon", country: "Spain", language: "CA"),
        Voice(languageCode: "cs-CZ", voiceName: "Zuzana", flagName: "czech-republic-flag-round-circle-icon", country: "Czech Republic", language: "CS"),
        Voice(languageCode: "da-DK", voiceName: "Sara", flagName: "denmark-flag-round-circle-icon", country: "Denmark", language: "DA"),
        Voice(languageCode: "de-DE", voiceName: "Anna", flagName: "germany-flag-round-circle-icon", country: "Germany", language: "DE"),
        Voice(languageCode: "el-GR", voiceName: "Melina", flagName: "greece-flag-round-circle-icon", country: "Greece", language: "EL"),
        Voice(languageCode: "en-AU", voiceName: "Karen", flagName: "australia-flag-round-circle-icon", country: "Australia", language: "EN"),
        Voice(languageCode: "en-GB", voiceName: "Daniel", flagName: "uk-flag-round-circle-icon", country: "United Kingdom", language: "EN"),
        Voice(languageCode: "en-IE", voiceName: "Moira", flagName: "ireland-flag-round-circle-icon", country: "Ireland", language: "EN"),
        Voice(languageCode: "en-IN", voiceName: "Rishi", flagName: "india-flag-round-circle-icon", country: "India", language: "EN"),
        Voice(languageCode: "en-US", voiceName: "Trinoids", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN"),
        Voice(languageCode: "en-US", voiceName: "Albert", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN"),
        Voice(languageCode: "en-US", voiceName: "Jester", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN"),
        Voice(languageCode: "en-US", voiceName: "Samantha", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN"),
        Voice(languageCode: "en-US", voiceName: "Whisper", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN"),
        Voice(languageCode: "en-US", voiceName: "Superstar", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN"),
        Voice(languageCode: "en-US", voiceName: "Bells", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN"),
        Voice(languageCode: "en-US", voiceName: "Organ", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN"),
        Voice(languageCode: "en-US", voiceName: "Bad News", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN"),
        Voice(languageCode: "en-US", voiceName: "Bubbles", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN"),
        Voice(languageCode: "en-US", voiceName: "Junior", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN"),
        Voice(languageCode: "en-US", voiceName: "Bahh", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN"),
        Voice(languageCode: "en-US", voiceName: "Wobble", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN"),
        Voice(languageCode: "en-US", voiceName: "Boing", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN"),
        Voice(languageCode: "en-US", voiceName: "Good News", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN"),
        Voice(languageCode: "en-US", voiceName: "Zarvox", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN"),
        Voice(languageCode: "en-US", voiceName: "Ralph", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN"),
        Voice(languageCode: "en-US", voiceName: "Cellos", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN"),
        Voice(languageCode: "en-US", voiceName: "Kathy", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN"),
        Voice(languageCode: "en-US", voiceName: "Fred", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN"),
        Voice(languageCode: "en-ZA", voiceName: "Tessa", flagName: "south-africa-flag-round-circle-icon", country: "South Africa", language: "EN"),
        Voice(languageCode: "es-ES", voiceName: "Mónica", flagName: "spain-country-flag-round-icon", country: "Spain", language: "ES"),
        Voice(languageCode: "es-MX", voiceName: "Paulina", flagName: "mexico-flag-round-circle-icon", country: "Mexico", language: "ES"),
        Voice(languageCode: "fi-FI", voiceName: "Satu", flagName: "finland-flag-round-circle-icon", country: "Finland", language: "FI"),
        Voice(languageCode: "fr-CA", voiceName: "Amélie", flagName: "canada-flag-round-circle-icon", country: "Canada", language: "FR"),
        Voice(languageCode: "fr-FR", voiceName: "Thomas", flagName: "france-flag-round-circle-icon", country: "France", language: "FR"),
        Voice(languageCode: "he-IL", voiceName: "Carmit", flagName: "israel-flag-round-circle-icon", country: "Israel", language: "HE"),
        Voice(languageCode: "hi-IN", voiceName: "Lekha", flagName: "india-flag-round-circle-icon", country: "India", language: "HI"),
        Voice(languageCode: "hr-HR", voiceName: "Lana", flagName: "croatia-flag-round-circle-icon", country: "Croatia", language: "HR"),
        Voice(languageCode: "hu-HU", voiceName: "Tünde", flagName: "hungary-flag-round-circle-icon", country: "Hungary", language: "HU"),
        Voice(languageCode: "id-ID", voiceName: "Damayanti", flagName: "indonesia-flag-round-circle-icon", country: "Indonesia", language: "ID"),
        Voice(languageCode: "it-IT", voiceName: "Alice", flagName: "italy-flag-round-circle-icon", country: "Italy", language: "IT"),
        Voice(languageCode: "ja-JP", voiceName: "Kyoko", flagName: "japan-flag-round-circle-icon", country: "Japan", language: "JA"),
        Voice(languageCode: "ko-KR", voiceName: "Yuna", flagName: "south-korea-flag-round-circle-icon", country: "South Korea", language: "KO"),
        Voice(languageCode: "ms-MY", voiceName: "Amira", flagName: "malaysia-flag-round-circle-icon", country: "Malaysia", language: "MS"),
        Voice(languageCode: "nb-NO", voiceName: "Nora", flagName: "norway-flag-round-circle-icon", country: "Norway", language: "NB"),
        Voice(languageCode: "nl-BE", voiceName: "Ellen", flagName: "belgium-flag-round-circle-icon", country: "Belgium", language: "NL"),
        Voice(languageCode: "nl-NL", voiceName: "Xander", flagName: "netherlands-flag-round-circle-icon", country: "Netherlands", language: "NL"),
        Voice(languageCode: "pl-PL", voiceName: "Zosia", flagName: "poland-flag-round-circle-icon", country: "Poland", language: "PL"),
        Voice(languageCode: "pt-BR", voiceName: "Luciana", flagName: "brazil-flag-round-circle-icon", country: "Brazil", language: "PT"),
        Voice(languageCode: "pt-PT", voiceName: "Joana", flagName: "portugal-flag-round-circle-icon", country: "Portugal", language: "PT"),
        Voice(languageCode: "ro-RO", voiceName: "Ioana", flagName: "romania-flag-round-circle-icon", country: "Romania", language: "RO"),
        Voice(languageCode: "ru-RU", voiceName: "Milena", flagName: "russia-flag-round-circle-icon", country: "Russia", language: "RU"),
        Voice(languageCode: "sk-SK", voiceName: "Laura", flagName: "slovakia-flag-round-circle-icon", country: "Slovakia", language: "SK"),
        Voice(languageCode: "sv-SE", voiceName: "Alva", flagName: "sweden-flag-round-circle-icon", country: "Sweden", language: "SV"),
        Voice(languageCode: "th-TH", voiceName: "Kanya", flagName: "thailand-flag-round-circle-icon", country: "Thailand", language: "TH"),
        Voice(languageCode: "tr-TR", voiceName: "Yelda", flagName: "turkey-flag-round-circle-icon", country: "Turkey", language: "TR"),
        Voice(languageCode: "uk-UA", voiceName: "Lesya", flagName: "ukraine-flag-round-circle-icon", country: "Ukraine", language: "UK"),
        Voice(languageCode: "vi-VN", voiceName: "Linh", flagName: "vietnam-flag-round-circle-icon", country: "Vietnam", language: "VI"),
        Voice(languageCode: "zh-CN", voiceName: "Tingting", flagName: "china-flag-round-circle-icon", country: "China", language: "ZH"),
        Voice(languageCode: "zh-HK", voiceName: "Sinji", flagName: "hong-kong-flag-round-circle-icon", country: "Hong Kong", language: "ZH"),
        Voice(languageCode: "zh-TW", voiceName: "Meijia", flagName: "taiwan-flag-round-circle-icon", country: "Taiwan", language: "ZH")
    ]
    var body: some View {
        ZStack {
            VStack {
                Spacer(minLength: 20)
                
                List {
                    ForEach(voices) { voice in
                        VoiceSelectorListItemView(voice: voice, selectedVoice: $selectedVoice)
                    }
                }
            }
            
            VStack {
                VStack {
                    HStack {
                        Text("Select Voice")
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

#Preview {
    VoiceSelectorView()
}
