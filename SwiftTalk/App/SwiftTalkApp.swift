//
//  SwiftTalkApp.swift
//  SwiftTalk
//
//  Created by Aman Bind on 07/03/24.
//

import SwiftData
import SwiftUI
import AVFoundation

@main
struct SwiftTalkApp: App {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
    @AppStorage("appTintColor") var tintColor: Color = .appTint
    
    init() {
            // Configure audio session for background playback
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio)
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print("Failed to configure audio session: \(error)")
            }
        }

    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                MainTabbedView()
                    .tint(tintColor)
            } else {

                OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)
            }
        }
        .modelContainer(for: [TextData.self, DailyStats.self])
    }
}
