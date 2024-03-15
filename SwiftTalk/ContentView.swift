//
//  ContentView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 07/03/24.
//

import SwiftUI

enum FocusedField: Hashable {
    case search
}

struct ContentView: View {
    @State private var searchText: String = ""

    @State private var showAddNewTextView = false

    @FocusState private var focusedField: FocusedField?

    @State var isFocused: Bool = false

    @State private var showThirdView = false

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: Constants.Fonts.AbrilFatfaceR, size: 25)!]

        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: Constants.Fonts.AbrilFatfaceR, size: 40)!]
    }

    var body: some View {
        NavigationView(content: {
            VStack {
                SearchView(searchText: $searchText, focus: _focusedField)
                List {
                    ForEach(["aman", "bind", "kumar", "rajesh", "mithilesh", "chakraborty", "Pandey", "jeevi"], id: \.self) { _ in

                        ListItemView()
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("SwiftTalk")
            .navigationBarTitleDisplayMode(focusedField == .search ? .inline : .automatic)
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
            AddNewTextOptionsView()
                .presentationDetents([.height(520)])

        })
        
    }
}

#Preview {
    ContentView()
}
