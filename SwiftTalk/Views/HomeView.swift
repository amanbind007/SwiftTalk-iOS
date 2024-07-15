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
    @State var isCorrect: Bool = true

    @Query(sort: \TextData.dateTime, order: .reverse) var textDatas: [TextData]

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: Constants.Fonts.NotoSerifSB, size: 18)!]
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: Constants.Fonts.NotoSerifSB, size: 40)!]
    }

    var body: some View {
        NavigationStack(path: $navigationState.targetDestination) {
            NavigationLink(value: navigationState.targetDestination) {
                EmptyView()
            }
            .navigationDestination(for: TextSource.self) { target in
                if target == .textInput {
                    AddNewTextView(textData: TextData(textTitle: nil, text: "", textSource: .textInput), isEditing: true, isFocused: true, isSaved: false)
                }
            }

            VStack {
                List {
                    ForEach(textDatas, id: \.id) { textData in
                        NavigationLink(destination: {
                            AddNewTextView(textData: textData, isEditing: false, isFocused: false, isSaved: true)
                        }, label: {
                            ListItemView(textData: textData)
                                .contextMenu {
                                    Button {
                                        newTitle = textData.textTitle!
                                        selectedTextData = textData
                                        showTitleUpdateAlert = true

                                        // Reset check to original state
                                        isCorrect = true
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
                }
                .listStyle(.sidebar)
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            }
            .navigationTitle("SwiftTalk")
            .toolbar(content: {
                ToolbarItem {
                    Button(action: {
                        showAddNewTextOptionsView.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                    })
                }
            })
        }
        .sheet(isPresented: $showAddNewTextOptionsView, content: {
            AddNewTextOptionsView(navigationState: $navigationState, showAddNewTextOptionsView: $showAddNewTextOptionsView)
                .presentationDetents([.height(520)])
        })
        .overlay(
            CustomAlertView(
                isPresented: $showTitleUpdateAlert,
                newTitle: $newTitle,
                isCorrect: $isCorrect,
                onSave: verifyAndUpdate
            )
        )
    }

    func verifyAndUpdate() {
        if !newTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            if let selectedTextData = selectedTextData {
                isCorrect = true
                selectedTextData.textTitle = newTitle
                do {
                    try modelContext.save()
                    showTitleUpdateAlert = false // Dismiss the alert
                } catch {
                    print(error)
                }
            }
        } else {
            isCorrect = false
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: TextData.self)
}
