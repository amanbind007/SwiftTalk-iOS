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
    @AppStorage("appTintColor") var tintColor: Color = .init(UIColor.green)

    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                // Some Onboarding View

            } else {
                MainView()
                    .tint(Color(red: 1, green: 0.298, blue: 0.298))
            }
        }
        .modelContainer(for: [TextData.self, DailyStats.self])
    }
}
