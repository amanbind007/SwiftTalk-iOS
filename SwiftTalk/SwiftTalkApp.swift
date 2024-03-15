//
//  SwiftTalkApp.swift
//  SwiftTalk
//
//  Created by Aman Bind on 07/03/24.
//

import SwiftUI

@main
struct SwiftTalkApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: {
                    for family: String in UIFont.familyNames {
                        print(family)
                        for names: String in UIFont.fontNames(forFamilyName: family) {
                            print("== \(names)")
                        }
                    }
                })
        }
    }
}
