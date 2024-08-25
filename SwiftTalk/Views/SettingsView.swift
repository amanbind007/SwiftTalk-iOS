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

                Section {
                    Toggle(isOn: $autoScroll, label: {
                        Text("Auto Scroll to higlighted Text")
                            .font(NotoFont.Regular(16))
                    })

                } header: {
                    Text("Auto-Scroll")
                }

                Section(header: Text("Fonts")) {
                    NavigationLink {
                        FontSelectorView(selectedfont: $selectedFont)
                    } label: {
                        HStack {
                            Text("Font \(Int(self.textSize))")
                                .font(NotoFont.Regular(16))
                            Spacer()
                            Text("Selected Font")
                                .font(.custom(selectedFont, size: 16))
                        }
                    }
                }

                Section(header: Text("Colors")) {
                    ColorPicker("Background Color", selection: self.$backgroundColor)
                        .font(NotoFont.Regular(16))
                    ColorPicker("Foreground Color", selection: self.$foregroundColor)
                        .font(NotoFont.Regular(15))
                }

                Section(header: Text("Text Size")) {
                    HStack {
                        Text("Text Size: \(Int(self.textSize))")
                            .font(NotoFont.Regular(16))
                        Stepper("", value: self.$textSize, in: 10...30, step: 1)
                    }

                    HStack {
                        Text("This is Preview Text Example") { string in

                            if let range = string.range(of: "Preview Text") { /// here!
                                string[range].foregroundColor = self.foregroundColor
                                string[range].backgroundColor = self.backgroundColor
                            }
                        }
                        .font(.custom(selectedFont, size: self.textSize))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 3)
                            .foregroundStyle(Color.green)
                    }
                }
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

extension Text {
    init(_ string: String, configure: (inout AttributedString) -> Void) {
        var attributedString = AttributedString(string) /// create an `AttributedString`
        configure(&attributedString) /// configure using the closure
        self.init(attributedString) /// initialize a `Text`
    }
}

#Preview {
    SettingsView()
}
