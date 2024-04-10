//
//  VoiceSpeedSelector.swift
//  SwiftTalk
//
//  Created by Aman Bind on 09/04/24.
//

import SwiftUI

struct VoiceSpeedPitchSelectorView: View {
    @State var voiceSpeedSliderValue = 1.0
    @State var voicePitchSliderValue = 1.0
    var body: some View {
        ZStack {
            Color.accent2
                .ignoresSafeArea()
            VStack {
                Spacer(minLength: 30)
                
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
                        .font(.custom(Constants.Fonts.NotoSerifR, size: 16))
                }
                .symbolEffect(.bounce, value: voiceSpeedSliderValue)
                .imageScale(.large)
                
                HStack {
                    Text("0.5x")
                        .font(.custom(Constants.Fonts.NotoSerifR, size: 16))
                    LinearGradientSlider(value: $voiceSpeedSliderValue, range: 0.5...5, step: 0.5) { _ in
                        // Update Default for speed
                    }
                    Text("5.0x")
                        .font(.custom(Constants.Fonts.NotoSerifR, size: 16))
                }
                .padding()
                .offset(y: -20)
                
                HStack {
                    Image(systemName: "waveform.path")
                    Text("Utterence Pitch \(trimValue(value: voicePitchSliderValue))x")
                        .font(.custom(Constants.Fonts.NotoSerifR, size: 16))
                }
                .symbolEffect(.bounce, value: voicePitchSliderValue)
                .imageScale(.large)
                
                HStack {
                    Text("1.0x")
                        .font(.custom(Constants.Fonts.NotoSerifR, size: 16))
                    LinearGradientSlider(value: $voicePitchSliderValue, range: 1...5, step: 0.5) { _ in
                        // Update Default for speed
                    }
                    Text("5.0x")
                        .font(.custom(Constants.Fonts.NotoSerifR, size: 16))
                }
                .padding()
                .offset(y: -20)
                
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
    
    func trimValue(value: Double) -> String {
        return String(format: "%0.1f", value)
    }
}

#Preview {
    VoiceSpeedPitchSelectorView()
}
