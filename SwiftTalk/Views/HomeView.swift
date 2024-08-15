//
//  ContentView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 07/03/24.
//

import Lottie
import SwiftData
import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) var modelContext

    @State var showAddNewTextOptionsView = false

    @State private var searchText: String = ""
    @State var navigationState = NavigationStateViewModel()
    @State var showTitleUpdateAlert: Bool = false
    @State var showInfoCardView: Bool = false
    @State var newTitle: String = ""
    @State var selectedTextData: TextData?
    @State var isCorrect: Bool = true

    @Binding var showTabView: Bool

    @Query(sort: \TextData.dateTime, order: .reverse) var textDatas: [TextData]

    var body: some View {
        NavigationStack(path: $navigationState.targetDestination) {
            // Open AddNewTextView if user selects input
            // text option in 'add new text options'
            OpenAddNewTextView

            VStack {
                if textDatas.isEmpty {
                    EmptyHomeView

                } else {
                    SavedTextListView
                }
            }
            .toolbarBackground(Color.navbar, for: .navigationBar)
            .navigationTitle("SwiftTalk")
            .navigationBarTitleDisplayMode(.large)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always)
            )
        }
        .sheet(
            isPresented: $showAddNewTextOptionsView,
            content: {
                AddNewTextOptionsView(
                    navigationState: $navigationState,
                    showAddNewTextOptionsView: $showAddNewTextOptionsView
                )
                .presentationDetents([.height(520)])
            }
        )
        .overlay(
            CustomAlertView(
                isPresented: $showTitleUpdateAlert,
                newTitle: $newTitle,
                isCorrect: $isCorrect,
                onSave: verifyAndUpdate
            )
            .animation(.easeInOut, value: showTitleUpdateAlert)
        )
        .overlay(
            InfoCardView(isPresented: $showInfoCardView, textData: selectedTextData)
        )
    }

    func verifyAndUpdate() {
        if !newTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            if let selectedTextData = selectedTextData {
                isCorrect = true
                selectedTextData.textTitle = newTitle
                do {
                    try modelContext.save()
                    showTitleUpdateAlert = false
                } catch {
                    print(error)
                }
            }
        } else {
            isCorrect = false
        }
    }

    func deleteObject(textData: TextData) {
        do {
            modelContext.delete(textData)
            try modelContext.save()

        } catch {
            print("Delete Error: \(error)")
        }
    }
}

// MARK: - Empty Home View

extension HomeView {
    @ViewBuilder
    var EmptyHomeView: some View {
        ZStack {
            BackgroundView()

            VStack {
                LottieView(animation: .named("EmptyAnimation"))
                    .playing(loopMode: .loop)
                    .frame(height: 300)

                Text("I have nothing speak!")

                Button {
                    showAddNewTextOptionsView.toggle()
                } label: {
                    Text("Add some new Text to Read")
                        .font(NotoFont.Regular(18))
                        .padding(10)
                        .foregroundStyle(.white)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.blue)
                        }
                }
            }
        }
    }
}

// MARK: - Saved Text List View

extension HomeView {
    @ViewBuilder
    var SavedTextListView: some View {
        ZStack(alignment: .bottomTrailing) {
            List {
                ForEach(textDatas, id: \.id) { textData in
                    NavigationLink(destination: {
                        AddNewTextView(textData: textData, isEditing: false, isFocused: false, isSaved: true, showTabView: $showTabView)
                    }, label: {
                        ListItemView(textData: textData, parentListType: .HomeViewList)
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

                                Button {
                                    deleteObject(textData: textData)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }

                                Button {
                                    selectedTextData = textData
                                    showInfoCardView = true
                                } label: {
                                    Label("Info", systemImage: "info.bubble")
                                }
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    deleteObject(textData: textData)
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
            .scrollContentBackground(.hidden)
            .listStyle(.sidebar)
            .listRowSpacing(10)

            Button(action: {
                showAddNewTextOptionsView.toggle()
            }, label: {
                Circle()
                    .frame(width: 55, height: 55)
                    .foregroundStyle(Color.appTint)
                    .overlay {
                        Image(systemName: "plus")
                            .resizable()
                            .bold()
                            .foregroundStyle(.white)
                            .padding(15)
                    }

            })
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(1), radius: 10, x: -7, y: -7)
            .padding(.vertical, 80)
            .padding(.horizontal)
        }
        .background(
            BackgroundView()
        )
    }
}

// MARK: - Open TextView from Home View

extension HomeView {
    @ViewBuilder
    var OpenAddNewTextView: some View {
        NavigationLink(value: navigationState.targetDestination) {
            EmptyView()
        }
        .navigationDestination(for: TextSource.self) { target in
            if target == .textInput {
                AddNewTextView(textData: TextData(textTitle: nil, text: "", textSource: .textInput), isEditing: true, isFocused: true, isSaved: false, showTabView: $showTabView)
            }
        }
    }
}

#Preview {
    HomeView(showTabView: .constant(true))
        .modelContainer(for: TextData.self)
}
