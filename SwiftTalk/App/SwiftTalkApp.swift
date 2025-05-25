//
//  SwiftTalkApp.swift
//  SwiftTalk
//
//  Created by Aman Bind on 07/03/24.
//

import SwiftData
import SwiftUI

@main
struct SwiftTalkApp: App {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
    @AppStorage("appTintColor") var tintColor: Color = .appTint

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
