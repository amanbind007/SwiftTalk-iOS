//
//  SwiftTalkApp.swift
//  SwiftTalk
//
//  Created by Aman Bind on 07/03/24.
//

import SwiftUI

@main
struct SwiftTalkApp: App {
    @State var navigationStateVM = NavigationStateViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(navigationStateVM)
        }
    }
}
