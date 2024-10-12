//
//  ResetSettingsView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 08/10/24.
//

import SwiftUI

enum ResetOption {
    case data
    case setting
    case dataAndSetting
    
    var message : String {
        switch self {
        case .data: return "Are you sure you want to reset all the reading texts and progress stats in the app"
        case .setting: return "Are you sure you want to reset all the settings like text view customization, voice speech, rate, text color, backgroung color, etc."
        case .dataAndSetting: return "Are you sure you want to resets all the everything in the app, both data and settings"
        
        }
    }
}

struct ResetSettingsView: View {

    @AppStorage("selectedVoice") var selectedVoiceIdentifier = "com.apple.speech.synthesis.voice.Samantha"
    @AppStorage("selectedVoiceFlag") var selectedVoiceFlagIcon = "usa"
    @AppStorage("voiceSpeed") var voiceSpeedSliderValue = 0.5
    @AppStorage("voicePitch") var voicePitchSliderValue = 1.0
    @AppStorage("sortOrder") var selectedSortOrder: SortOrder = .recent
    @AppStorage("textSize") var textSize = 16.0
    @AppStorage("selectedFont") var selectedFont = Constants.Fonts.NotoRegular
    @AppStorage("backgroundColor") var backgroundColor: Color = .init(UIColor(red: 1.00, green: 0.97, blue: 0.42, alpha: 1.00))
    @AppStorage("foregroundColor") var foregroundColor: Color = .init(UIColor(red: 0.83, green: 0.00, blue: 0.00, alpha: 1.00))
    @AppStorage("autoScroll") var autoScroll = true
    
    @State var showResetAlert: Bool = false
    @State var selectedResetOption: ResetOption? = nil

    var body: some View {
        List {
            Section {
                Button(role: .destructive) {
                    selectedResetOption = .setting
                    showResetAlert = true
                } label: {
                    HStack {
                        Text("Reset Settings")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "gearshape.arrow.trianglehead.2.clockwise.rotate.90")
                    }
                }
            } footer: {
                Text("Resets all the reading texts and progress stats in the app")
                    .font(.caption)
            }

            Section {
                Button(role: .destructive) {
                    selectedResetOption = .data
                    showResetAlert = true
                } label: {

                    HStack {
                        Text("Reset Data")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "swiftdata")
                    }

                }
            } footer: {
                Text("Reset all the settings like text view customization, voice speech, rate, text color, backgroung color, etc.")
                    .font(.caption)
            }

            Section {
                Button(role: .destructive) {
                    selectedResetOption = .dataAndSetting
                    showResetAlert = true
                } label: {
                    HStack {
                        Text("Reset Data & Settings")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "gearshape.arrow.trianglehead.2.clockwise.rotate.90")
                        Text("+")
                        Image(systemName: "swiftdata")
                    }
                }
            } footer: {
                Text("Resets all the everything in the app, both data and settings")
                    .font(.caption)
            }
        }
        .alert("Warning", isPresented: $showResetAlert) {
            Button("cancel", role: .cancel) {
                // no action required
            }
            
            Button("I'm Sure!", role: .destructive) {
                switch selectedResetOption {
                case .data:
                    DataCoordinator.shared.resetContainer()
                case .setting:
                    resetAppSettings()
                case .dataAndSetting:
                    resetAppSettings()
                    DataCoordinator.shared.resetContainer()
                case nil: break
                    //no
                }
            }
        } message: {
            Text(selectedResetOption?.message ?? "")
        }


    }
    
    func resetAppSettings(){
        selectedVoiceIdentifier = "com.apple.speech.synthesis.voice.Samantha"
        selectedVoiceFlagIcon = "usa"
        voiceSpeedSliderValue = 0.5
        voicePitchSliderValue = 1.0
        selectedSortOrder = .recent
        textSize = 16.0
        selectedFont = Constants.Fonts.NotoRegular
        backgroundColor = .init(UIColor(red: 1.00, green: 0.97, blue: 0.42, alpha: 1.00))
        foregroundColor = .init(UIColor(red: 0.83, green: 0.00, blue: 0.00, alpha: 1.00))
        autoScroll = true
    }
}

#Preview {
    ResetSettingsView()
}
