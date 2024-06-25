//
//  ContentView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 07/03/24.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) var modelContext

    @State var showAddNewTextOptionsView = false

    @State private var searchText: String = ""
    @State var navigationState = NavigationStateViewModel()
    @State var showTitleUpdateAlert: Bool = false
    @State var newTitle: String = ""
    @State var selectedTextData: TextData?
    @Query var textDatas: [TextData]

    @Environment(AddNewTextViewModel.self) var addNewTextVM

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: Constants.Fonts.NotoSerifSB, size: 18)!]

        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: Constants.Fonts.NotoSerifSB, size: 40)!]
    }

    var body: some View {
        NavigationStack(path: $navigationState.targetDestination) {
            NavigationLink(value: navigationState.targetDestination) {
                EmptyView()
            }
            .navigationDestination(for: AddNewTextOption.self) { target in
                if target == .textInput {
                    AddNewTextView(textSource: .textInput, addNewTextVM: addNewTextVM, textData: nil)
                }
            }

            VStack {
                List {
                    ForEach(textDatas, id: \.id) { textData in
                        NavigationLink(destination: {
                            AddNewTextView(textSource: textData.textSource, addNewTextVM: addNewTextVM, textData: textData)
                        }, label: {
                            ListItemView(textData: textData)
                                .contextMenu {
                                    Button {
                                        newTitle = textData.textTitle // Initialize with current title
                                        selectedTextData = textData
                                        showTitleUpdateAlert = true
                                    } label: {
                                        Label("Update Title", systemImage: "square.and.pencil")
                                    }
                                }
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        modelContext.delete(textData)
                                        do {
                                            try modelContext.save()
                                        } catch {
                                            print(error)
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }

                        })
                    }
                    .alert("Enter new title", isPresented: $showTitleUpdateAlert, actions: {
                        TextField("Enter new title", text: $newTitle)
                        Button("OK", action: {
                            if let selectedTextData = selectedTextData {
                                selectedTextData.textTitle = newTitle
                                do {
                                    try modelContext.save()
                                } catch {
                                    print(error)
                                }
                            }
                        })
                        Button("Cancel", role: .cancel, action: {})
                    }, message: {
                        Text("Enter a new title for the item.")
                    })
                }

                .listStyle(.sidebar)
                .searchable(text: $searchText)
            }
            .navigationTitle("SwiftTalk")
            .toolbar(content: {
                ToolbarItem {
                    // This button triggers the Sheet view
                    Button(action: {
                        showAddNewTextOptionsView.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                    })
                }
            })
        }
        .sheet(isPresented: $showAddNewTextOptionsView, content: {
            AddNewTextOptionsView(navigationState: $navigationState, showAddNewTextOptionsView: $showAddNewTextOptionsView, addNewTextVM: addNewTextVM)
                .presentationDetents([.height(520)])

        })
    }
}

#Preview {
    HomeView()
        .modelContainer(for: TextData.self)
}
