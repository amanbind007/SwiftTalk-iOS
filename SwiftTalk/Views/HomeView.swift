//
//  ContentView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 07/03/24.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""
    @State var navigationState = NavigationStateViewModel()

    @Environment(AddNewTextViewModel.self) var addNewTextVM

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: Constants.Fonts.AbrilFatfaceR, size: 25)!]

        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: Constants.Fonts.AbrilFatfaceR, size: 40)!]
    }

    var body: some View {
        NavigationStack(path: $navigationState.targetDestination) {
            NavigationLink(value: navigationState.targetDestination) {
                EmptyView()
            }
            .navigationDestination(for: AddNewTextOption.self) { target in
                switch target {
                case .textInput:
                    AddNewTextView(textSource: target, addNewTextVM: addNewTextVM)
                case .pdfDocument:
                    AddNewTextView(textSource: target, addNewTextVM: addNewTextVM)
                case .camera:
                    AddNewTextView(textSource: target, addNewTextVM: addNewTextVM)
                case .photoLibrary:
                    AddNewTextView(textSource: target, addNewTextVM: addNewTextVM)
                case .webpage:
                    AddNewTextView(textSource: target, addNewTextVM: addNewTextVM)
                case .wordDocument:
                    AddNewTextView(textSource: target, addNewTextVM: addNewTextVM)
                }
            }

            VStack {
                List {
                    ForEach(["aman", "bind", "kumar", "rajesh", "mithilesh", "chakraborty", "Pandey", "jeevi"], id: \.self) { _ in

                        ListItemView()
                    }
                }
                .listStyle(.sidebar)
                .searchable(text: $searchText)
            }
            .navigationTitle("SwiftTalk")
            .toolbar(content: {
                ToolbarItem {
                    // This button triggers the Sheet view
                    Button(action: {
                        navigationState.showAddNewTextOptionsView.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                    })
                }
            })
        }
        .sheet(isPresented: $navigationState.showAddNewTextOptionsView, content: {
            AddNewTextOptionsView(navigationState: $navigationState, addNewTextVM: addNewTextVM)
                .presentationDetents([.height(520)])

        })
    }
}

#Preview {
    HomeView()
}
