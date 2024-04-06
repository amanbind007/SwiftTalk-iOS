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

struct HomeView: View {
    @State private var searchText: String = ""

    @FocusState private var focusedField: FocusedField?

    @State var navigationStateVM = NavigationStateViewModel()

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: Constants.Fonts.AbrilFatfaceR, size: 25)!]

        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: Constants.Fonts.AbrilFatfaceR, size: 40)!]
    }

    var body: some View {
        NavigationStack(path: $navigationStateVM.targetDestination) {
            NavigationLink(value: navigationStateVM.targetDestination) {
                EmptyView()
            }
            .navigationDestination(for: AddNewTextOption.self) { target in
                switch target {
                case .textInput:
                    AddNewTextView()
                case .pdfDocument:
                    EmptyView()
                case .camera:
                    EmptyView()
                case .photoLibrary:
                    EmptyView()
                case .webpage:
                    EmptyView()
                case .wordDocument:
                    EmptyView()
                }
            }

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
                    // This button triggers the Sheet view
                    Button(action: {
                        navigationStateVM.showAddNewTextOptionsView.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                    })
                }
            })
        }
        .sheet(isPresented: $navigationStateVM.showAddNewTextOptionsView, content: {
            AddNewTextOptionsView(viewModel: navigationStateVM)
                .presentationDetents([.height(520)])

        })
    }
}

#Preview {
    HomeView()
}
