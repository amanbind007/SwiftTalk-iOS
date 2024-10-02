//
//  Settings.swift
//  SwiftTalk
//
//  Updated by Aman Bind on 09/07/24.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("voiceSpeed") var voiceSpeedSliderValue = 0.5
    @AppStorage("voicePitch") var voicePitchSliderValue = 1.0
    @AppStorage("textSize") var textSize = 16.0
    @AppStorage("selectedFont") var selectedFont = Constants.Fonts.NotoRegular
    @AppStorage("backgroundColor") var backgroundColor: Color = .init(UIColor(red: 1.00, green: 0.97, blue: 0.42, alpha: 1.00))
    @AppStorage("foregroundColor") var foregroundColor: Color = .init(UIColor(red: 0.83, green: 0.00, blue: 0.00, alpha: 1.00))
    @AppStorage("autoScroll") var autoScroll = true

    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var theme

    var body: some View {
        NavigationStack {
            Form {
                VoiceSettingsView()
                TextDisplayCustomizationView()
            }
            .navigationTitle("TTS Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        self.dismiss()
                    }
                    .font(NotoFont.Regular(16))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reset") {
                        self.voiceSpeedSliderValue = 0.5
                        self.voicePitchSliderValue = 1.0
                        self.textSize = 16.0
                        self.backgroundColor = .yellow
                        self.foregroundColor = .blue
                    }
                    .font(NotoFont.Regular(16))
                }
            })
        }
    }

    private func calculatePercentage(value: Double) -> Int {
        let percentage = value <= 0.5 ? (value / 0.5 * 100) : (value - 0.5) / 0.5 * 400 + 100
        return Int(percentage)
    }

    func trimValue(value: Double) -> String {
        return String(format: "%0.1f", value)
    }
}

#Preview {
    SettingsView()
}
