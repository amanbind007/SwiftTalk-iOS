//
//  SwiftTalkApp.swift
//  SwiftTalk
//
//  Created by Aman Bind on 07/03/24.
//

import SwiftUI
import SwiftData

@main
struct SwiftTalkApp: App {
    @State var addNewTextVM = AddNewTextViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(addNewTextVM)
                
        }
        .modelContainer(for: TextData.self)
        
    }
}
