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
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: [TextData.self, DailyStats.self])
    }
}

