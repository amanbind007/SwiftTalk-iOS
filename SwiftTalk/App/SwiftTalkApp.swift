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
    @AppStorage("isOnboarding") var isOnboarding: Bool = false
    @AppStorage("appTintColor") var tintColor: Color = .appTint

    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                // Some Onboarding View

            } else {
                MainTabbedView()
                    .tint(tintColor)
            }
        }
        .modelContainer(for: [TextData.self, DailyStats.self])
    }
}
