//
//  ContentView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 07/03/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var searchText: String = ""
    @State var navigationStateVM = NavigationStateViewModel()
    @State var addNewTextVM = AddNewTextViewModel()

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: Constants.Fonts.AbrilFatfaceR, size: 20)!]

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
                    AddNewTextView(addNewTextVM: addNewTextVM)
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
                        navigationStateVM.showAddNewTextOptionsView.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                    })
                }
            })
        }
        .sheet(isPresented: $navigationStateVM.showAddNewTextOptionsView, content: {
            AddNewTextOptionsView(viewModel: $navigationStateVM, addNewTextVM: $addNewTextVM)
                .presentationDetents([.height(520)])

        })
    }
}

#Preview {
    HomeView()
}
