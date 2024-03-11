//
//  ContentView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 07/03/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showAddNewTextView = false

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "AbrilFatface-Regular", size: 25)!]

        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "AbrilFatface-Regular", size: 40)!]
        
    }

    var body: some View {
        NavigationView(content: {
            HomeView()
                .navigationTitle("SwiftTalk")
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar(content: {
                    ToolbarItem {
                        Button(action: {
                            showAddNewTextView = true
                        }, label: {
                            Image(systemName: "plus.circle")
                        })
                    }
                })

        })
        .sheet(isPresented: $showAddNewTextView, content: {
            AddNewTextView()
        })
    }
}

struct HomeView: View {
    var body: some View {
        VStack {
            SearchView()
            List {
                ForEach(["aman", "bind", "kumar"], id: \.self) { _ in

                    ListItemView()
                }
            }
            .listStyle(.plain)

        }
    }
}

#Preview {
    ContentView()
}
