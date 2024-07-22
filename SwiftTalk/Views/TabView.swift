//
//  TabView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 17/07/24.
//

import SwiftUI

struct MainView: View {
    @State private var tabSelection = 1
    var body: some View {
        TabView(selection: $tabSelection) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(1)

            StatsView(tabSelection: $tabSelection)
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.xaxis")
                }
                .tag(2)
        }
    }
}

#Preview {
    MainView()
}
