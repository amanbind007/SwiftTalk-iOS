//
//  ContentView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 07/03/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showNewView = false
    
    init(){
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: "AbrilFatface-Regular", size: 25)!]
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: "AbrilFatface-Regular", size: 40)!]
        
    }

    var body: some View {
        NavigationView(content: {
            HomeView()
                .navigationTitle("SwiftTalk")
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar(content: {
                    ToolbarItem {
                        Button(action: {
                            showNewView = true
                        }, label: {
                            Image(systemName: "plus.circle")
                        })
                    }
                })

        })
        .sheet(isPresented: $showNewView, content: {
            NewTextView()
        })
        
        
    }
}

struct HomeView: View {
    @State private var search: String = ""

    var body: some View {
        VStack {
            List {
                ForEach(["aman", "bind", "kumar"], id: \.self) { data in
                    Text(data)
                }
            }
            .searchable(text: $search, prompt: "search")
            .autocorrectionDisabled()
        }
    }
}

#Preview {
    ContentView()
}
