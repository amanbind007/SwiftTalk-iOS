//
//  VoiceSettingsView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 02/10/24.
//

import SwiftUI

struct VoiceSettingsView: View {
    @AppStorage("voiceSpeed") var voiceSpeedSliderValue = 0.5
    @AppStorage("voicePitch") var voicePitchSliderValue = 1.0
    
    var body: some View {
        Section(header: Text("Voice Speed")) {
            HStack {
                let percentage = calculatePercentage(value: self.voiceSpeedSliderValue)
                switch percentage {
                case 0..<50:
                    Image(systemName: "gauge.with.dots.needle.0percent")
                case 50..<100:
                    Image(systemName: "gauge.with.dots.needle.33percent")
                case 100..<300:
                    Image(systemName: "gauge.with.dots.needle.50percent")
                case 300..<500:
                    Image(systemName: "gauge.with.dots.needle.67percent")
                case 500:
                    Image(systemName: "gauge.with.dots.needle.100percent")
                default:
                    Image(systemName: "gauge.with.dots.needle.50percent")
                }

                Text("Utterance Speed \(percentage)%")
                    .font(NotoFont.Regular(16))
            }
            .symbolEffect(.bounce, value: self.voiceSpeedSliderValue)
            .imageScale(.large)

            HStack {
                Text("0.0x")
                    .font(NotoFont.Regular(16))
                Slider(value: self.$voiceSpeedSliderValue, in: 0.0...1.0, step: 0.01)
                Text("1.0x")
                    .font(NotoFont.Regular(16))
            }
        }
//                .font(NotoFont.Light(10))

        Section(header: Text("Voice Pitch")) {
            HStack {
                Image(systemName: "waveform.path")
                Text("Utterance Pitch \(self.trimValue(value: self.voicePitchSliderValue))x")
                    .font(NotoFont.Regular(16))
            }
            .symbolEffect(.bounce, value: self.voicePitchSliderValue)
            .imageScale(.large)

            HStack {
                Text("0.5x")
                    .font(NotoFont.Regular(16))
                Slider(value: self.$voicePitchSliderValue, in: 0.5...2.0, step: 0.1)
                Text("2.0x")
                    .font(NotoFont.Regular(16))
            }
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
    VoiceSettingsView()
}
