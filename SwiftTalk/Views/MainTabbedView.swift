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

    init() {
        let titleTextColor = UIColor.deepOrange

        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: titleTextColor, .font: UIFont(name: Constants.Fonts.NotoBold, size: 20)!]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: titleTextColor, .font: UIFont(name: Constants.Fonts.NotoBold, size: 40)!]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = titleTextColor.withAlphaComponent(0.1)
    }

    var body: some View {
        ZStack {
            if tabSelection == 0 {
                HomeView(showTabView: $showTabView)
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
