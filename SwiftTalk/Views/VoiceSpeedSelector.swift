//
//  VoiceSpeedSelector.swift
//  SwiftTalk
//
//  Created by Aman Bind on 09/04/24.
//

import SwiftUI

struct VoiceSpeedSelector: View {
    @State var voiceSpeedSliderValue = 1.0
    @State var voicePitchSliderValue = 1.0
    var body: some View {
        VStack {
            HStack {
                switch voiceSpeedSliderValue {
                case 0.5...1.0:
                    Image(systemName: "gauge.with.dots.needle.0percent")
                case 1.0...2.0:
                    Image(systemName: "gauge.with.dots.needle.33percent")
                case 2.0...3.0:
                    Image(systemName: "gauge.with.dots.needle.50percent")
                case 3.0...4.0:
                    Image(systemName: "gauge.with.dots.needle.67percent")
                case 4.0...5.0:
                    Image(systemName: "gauge.with.dots.needle.100percent")
                default:
                    Image(systemName: "gauge.with.dots.needle.50percent")
                }
                    
                Text("Utterence Speed \(trimValue(value: voiceSpeedSliderValue))x")
            }
            .symbolEffect(.bounce, value: voiceSpeedSliderValue)
            .imageScale(.large)
                    
            Slider(value: $voiceSpeedSliderValue, in: 0.5...5, step: 0.5) {
                Label("\(voiceSpeedSliderValue)", systemImage: "cloud")
            } minimumValueLabel: {
                Text("0.5x")
            } maximumValueLabel: {
                Text("5.0x")
            } onEditingChanged: { _ in
                // update Default for speed
            }
            .padding()
            .offset(y: -20)
            
            HStack {
                Image(systemName: "waveform.path")
                Text("Utterence Pitch \(trimValue(value: voicePitchSliderValue))x")
            }
            .symbolEffect(.bounce, value: voicePitchSliderValue)
            .imageScale(.large)
            
            Slider(value: $voicePitchSliderValue, in: 1...5, step: 0.5) {
                Label("\(voicePitchSliderValue)", systemImage: "cloud")
            } minimumValueLabel: {
                Text("1.0x")
            } maximumValueLabel: {
                Text("5.0x")
            } onEditingChanged: { _ in
                // update Default for speed
            }
            .padding()
            .offset(y: -20)
        }
    }
    
    func trimValue(value: Double) -> String {
        return String(format: "%0.1f", value)
    }
}

#Preview {
    VoiceSpeedSelector()
}
