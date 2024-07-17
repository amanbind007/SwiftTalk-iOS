//
//  TabView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 17/07/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            StatsView()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.xaxis")
                }
        }
    }
}

#Preview {
    MainView()
}
