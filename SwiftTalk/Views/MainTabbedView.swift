//
//  MainView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 17/07/24.
//

import SwiftUI

struct MainTabbedView: View {
    @State private var tabSelection = 0
    @State private var showTabView = true
    @Environment(\.modelContext) var modelContext

    var body: some View {
        ZStack {
            if tabSelection == 0 {
                HomeView(modelContext: modelContext, showTabView: $showTabView)
                    .tag(0)
            } else {
                StatsView(tabSelection: $tabSelection)
                    .tag(1)
            }

            if showTabView {
                VStack {
                    Spacer()
                    CustomTabView(selectedTab: $tabSelection)
                        .shadow(radius: 10)
                }
            }
        }
    }
}

#Preview {
    MainTabbedView()
}
