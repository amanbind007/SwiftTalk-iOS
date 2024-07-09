//
//  VoiceSpeedSelector.swift
//  SwiftTalk
//
//  Created by Aman Bind on 09/04/24.
//

import SwiftUI

struct VoiceSpeedPitchSelectorView: View {
    @AppStorage("voiceSpeed") var voiceSpeedSliderValue = 0.5
    @AppStorage("voicePitch") var voicePitchSliderValue = 1.0
    @AppStorage("textSize") var textSizeSliderValue = 16.0
    @AppStorage("selectedFont") var selectedFont = Constants.Fonts.NotoSerifR
    @State private var backgroundColor: Color = .white
    @State private var foregroundColor: Color = .black

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
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
                            .font(.custom("NotoSerifR", size: 16))
                    }
                    .symbolEffect(.bounce, value: self.voiceSpeedSliderValue)
                    .imageScale(.large)

                    HStack {
                        Text("0.0x")
                            .font(.custom("NotoSerifR", size: 16))
                        Slider(value: self.$voiceSpeedSliderValue, in: 0.0...1.0, step: 0.01) {
                            // Update Default for speed
                        }
                        Text("1.0x")
                            .font(.custom("NotoSerifR", size: 16))
                    }
                }
                .font(.custom("NotoSerifR", size: 10))

                Section(header: Text("Voice Pitch")) {
                    HStack {
                        Image(systemName: "waveform.path")
                        Text("Utterance Pitch \(self.trimValue(value: self.voicePitchSliderValue))x")
                            .font(.custom(Constants.Fonts.NotoSerifR, size: 16))
                    }
                    .symbolEffect(.bounce, value: self.voicePitchSliderValue)
                    .imageScale(.large)

                    HStack {
                        Text("0.5x")
                            .font(.custom(Constants.Fonts.NotoSerifR, size: 16))
                        LinearGradientSlider(value: self.$voicePitchSliderValue, range: 0.5...2.0, step: 0.1) { _ in
                            // Update Default for pitch
                        }
                        Text("2.0x")
                            .font(.custom(Constants.Fonts.NotoSerifR, size: 16))
                    }
                }
                .font(.custom(Constants.Fonts.NotoSerifR, size: 10))

                Section(header: Text("Fonts")) {
                    NavigationLink {
                        FontSelectorView(selectedfont: $selectedFont)
                    } label: {
                        HStack {
                            Text("Font \(Int(self.textSizeSliderValue))")
                                .font(.custom(Constants.Fonts.NotoSerifR, size: 16))

                            Spacer()
                            Text("Selected Font")
                                .font(.custom(selectedFont, size: 16))
                        }
                    }
                }
                .font(.custom(Constants.Fonts.NotoSerifR, size: 10))

                Section(header: Text("Text Size")) {
                    HStack {
                        Text("Text Size: \(Int(self.textSizeSliderValue))")
                            .font(.custom(Constants.Fonts.NotoSerifR, size: 16))
                        Stepper("", value: self.$textSizeSliderValue, in: 10...30, step: 1)
                    }

                    HStack {
                        Text("This is Preview Text Example") { string in

                            if let range = string.range(of: "Preview Text") { /// here!
                                string[range].foregroundColor = self.foregroundColor
                                string[range].backgroundColor = self.backgroundColor
                            }
                        }
                        .font(.custom(selectedFont, size: self.textSizeSliderValue))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    }
                    .background(.white)
                    .cornerRadius(8)
                }
                .font(.custom(Constants.Fonts.NotoSerifR, size: 10))

                Section(header: Text("Colors")) {
                    ColorPicker("Background Color", selection: self.$backgroundColor)
                        .font(.custom(Constants.Fonts.NotoSerifR, size: 16))
                    ColorPicker("Foreground Color", selection: self.$foregroundColor)
                        .font(.custom(Constants.Fonts.NotoSerifR, size: 16))
                }
                .font(.custom(Constants.Fonts.NotoSerifR, size: 10))
            }
            .navigationTitle("Change Voice Metric")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        self.dismiss()
                    }
                    .font(.custom(Constants.Fonts.NotoSerifR, size: 16))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reset") {
                        self.voiceSpeedSliderValue = 0.5
                        self.voicePitchSliderValue = 1.0
                        self.textSizeSliderValue = 16.0
                        self.backgroundColor = .white
                        self.foregroundColor = .black
                    }
                    .font(.custom(Constants.Fonts.NotoSerifR, size: 16))
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

extension Text {
    init(_ string: String, configure: (inout AttributedString) -> Void) {
        var attributedString = AttributedString(string) /// create an `AttributedString`
        configure(&attributedString) /// configure using the closure
        self.init(attributedString) /// initialize a `Text`
    }
}

#Preview {
    VoiceSpeedPitchSelectorView()
}
