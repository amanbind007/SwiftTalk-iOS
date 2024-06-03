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

    @State private var searchText: String = ""
    @State var navigationState = NavigationStateViewModel()
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
                switch target {
                case .textInput:
                    AddNewTextView(textSource: .textInput, addNewTextVM: addNewTextVM, text: nil, title: nil)
                case .pdfDocument:
                    AddNewTextView(textSource: .pdfDocument, addNewTextVM: addNewTextVM, text: nil, title: nil)
                case .camera:
                    AddNewTextView(textSource: .camera, addNewTextVM: addNewTextVM, text: nil, title: nil)
                case .photoLibrary:
                    AddNewTextView(textSource: .photoLibrary, addNewTextVM: addNewTextVM, text: nil, title: nil)
                case .webpage:
                    AddNewTextView(textSource: .webpage, addNewTextVM: addNewTextVM, text: nil, title: nil)
                case .wordDocument:
                    AddNewTextView(textSource: .wordDocument, addNewTextVM: addNewTextVM, text: nil, title: nil)
                case .textFile:
                    AddNewTextView(textSource: .textFile, addNewTextVM: addNewTextVM, text: nil, title: nil)
                }
            }

            VStack {
                List {
                    ForEach(textDatas, id: \.id) { textData in
                        
                        NavigationLink(destination: {
                            AddNewTextView(textSource: textData.textSource, addNewTextVM: addNewTextVM, text: textData.text, title: textData.textTitle)
                        }, label: {
                            ListItemView(textData: textData)
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        // Deleting fish from persistence storage on swipe
                                        modelContext.delete(textData)
                                        do {
                                            try modelContext.save()
                                        }
                                        catch {
                                            print(error.localizedDescription)
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        })
                            
                            
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
        .modelContainer(for: TextData.self)
}
