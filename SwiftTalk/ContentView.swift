//
//  ContentView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 07/03/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView(content: {
            
            HomeView()
                .navigationTitle("SwiftTalk")
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar(content: {
                    ToolbarItem {
                        Button(action: {}, label: {
                            Image(systemName: "plus.circle")
                        })
                    }
                })

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
