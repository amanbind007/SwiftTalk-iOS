//
//  VoiceSelectorView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 14/03/24.
//

import AVFAudio
import SwiftUI

struct VoiceSelectorView: View {
    @State var voices: [Voice] = []
    @State var searchText: String = ""

    @Environment(\.dismiss) var dismiss
    @State var speechManager = SpeechSynthesizer()

    init() {}

    var filteredVoices: [Voice] {
        if searchText.isEmpty {
            return voices
        } else {
            return voices.filter { voice in
                voice.languageCode.lowercased().contains(searchText.lowercased()) ||
                    voice.voiceName.lowercased().contains(searchText.lowercased()) ||
                    voice.country.lowercased().contains(searchText.lowercased()) ||
                    voice.language.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var groupedVoices: [String: [Voice]] {
        Dictionary(grouping: filteredVoices, by: { $0.language })
    }

    var body: some View {
        NavigationStack {
            Form {
                ForEach(groupedVoices.keys.sorted(), id: \.self) { key in
                    Section(header: Text(key)) {
                        ForEach(groupedVoices[key]!) { voice in
                            VoiceSelectorListItemView(voice: voice, speechManager: $speechManager)
                        }
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("Select Voice")
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(edges: [.bottom])
            .toolbar(content: {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                    .font(.custom(Constants.Fonts.NotoSerifR, size: 16))
                }
            })
        }

        .onAppear {
            fetchAvailableVoices()
        }
    }

    func fetchAvailableVoices() {
        let availableVoices = AVSpeechSynthesisVoice.speechVoices()
        voices = availableVoices.map { voice in
            let languageCode = voice.language
            let gender = voice.gender.rawValue == 1 ? "Female" : "Male"
            let identifier = voice.identifier
            let voiceName = voice.name
            let countryName = getCountryName(from: languageCode)
            let languageName = getLanguageName(from: languageCode)
            let sampleText = voiceSampleText[voice.language.components(separatedBy: "-")[0]]
            let flag = flagNames[voice.language.components(separatedBy: "-")[1]] ?? "world"
            let voice = Voice(languageCode: languageCode, voiceName: voiceName, country: countryName ?? "World", language: languageName ?? "Unknown", demoText: sampleText ?? "", identifier: identifier, gender: gender, flag: flag)

            return voice
        }
    }

    func getCountryName(from languageCode: String) -> String? {
        let components = languageCode.split(separator: "-")
        guard components.count == 2 else { return nil }

        let countryCode = String(components[1])

        let locale = Locale.current

        guard let countryName = locale.localizedString(forRegionCode: countryCode) else {
            return nil
        }

        return countryName
    }

    func getLanguageName(from languageCode: String) -> String? {
        let components = languageCode.split(separator: "-")
        guard components.count == 2 else { return nil }

        let languageCode = String(components[0])

        let locale = Locale.current

        guard let languageName = locale.localizedString(forLanguageCode: languageCode) else {
            return nil
        }

        return languageName
    }
}

#Preview {
    VoiceSelectorView()
}
