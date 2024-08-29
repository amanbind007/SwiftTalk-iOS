//
//  ContentView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 07/03/24.
//

import Lottie
import SwiftData
import SwiftUI

enum SortOrder: String {
    case recent
    case dateLowToHigh
    case dateHighToLow
    case AtoZ
    case ZtoA
}

struct HomeView: View {
    @State private var viewModel: HomeViewModel
    @Binding var showTabView: Bool
    @Query var textDatas: [TextData]
    @AppStorage("sortOrder") var selectedSortOrder: SortOrder = .recent

    init(modelContext: ModelContext, showTabView: Binding<Bool>) {
        _viewModel = State(wrappedValue: HomeViewModel(modelContext: modelContext))
        _showTabView = showTabView
    }

    var body: some View {
        NavigationStack(path: $viewModel.navigationState.targetDestination) {
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
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always)
            )
            .toolbar(content: {
                ToolbarItem {
                    Menu("Sort", systemImage: "line.3.horizontal.decrease.circle") {
                        Text("Sort Order")
                        Picker(selection: $selectedSortOrder) {
                            Text("Recently Accessed").tag(SortOrder.recent)
                            Text("Date Added - New to Old").tag(SortOrder.dateHighToLow)
                            Text("Date Added - Old to New").tag(SortOrder.dateLowToHigh)
                            Text("A to Z (Title)").tag(SortOrder.AtoZ)
                            Text("Z to A (Title)").tag(SortOrder.ZtoA)
                        } label: {
                            Text("Sort Options")
                        }
                    }
                }
            })
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.showSettingsView = true
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            })
        }
        .sheet(isPresented: $viewModel.showSettingsView, content: {
            SettingsView()
        })
        .sheet(isPresented: $viewModel.showAddNewTextOptionsView, content: {
            AddNewTextOptionsView(
                navigationState: $viewModel.navigationState,
                showAddNewTextOptionsView: $viewModel.showAddNewTextOptionsView
            )
            .presentationDetents([.height(520)])
        })
        .overlay(
            CustomAlertView(
                isPresented: $viewModel.showTitleUpdateAlert,
                newTitle: $viewModel.newTitle,
                isCorrect: $viewModel.isCorrect,
                onSave: viewModel.verifyAndUpdate
            )
            .animation(.easeInOut, value: viewModel.showTitleUpdateAlert)
        )
        .overlay(
            InfoCardView(isPresented: $viewModel.showInfoCardView, textData: viewModel.selectedTextData)
        )
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
                    viewModel.showAddNewTextOptionsView.toggle()
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
                ForEach(viewModel.filteredAndSortedTextData(textDatas), id: \.id) { textData in
                    NavigationLink(destination: {
                        AddNewTextView(textData: textData, isEditing: false, isFocused: false, isSaved: true, showTabView: $showTabView)
                    }, label: {
                        ListItemView(textData: textData, parentListType: .HomeViewList)
                            .contextMenu {
                                Button {
                                    viewModel.newTitle = textData.textTitle!
                                    viewModel.selectedTextData = textData
                                    viewModel.showTitleUpdateAlert = true
                                    viewModel.isCorrect = true
                                } label: {
                                    Label("Update Title", systemImage: "square.and.pencil")
                                }

                                Button {
                                    viewModel.deleteObject(textData: textData)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }

                                Button {
                                    viewModel.selectedTextData = textData
                                    viewModel.showInfoCardView = true
                                } label: {
                                    Label("Info", systemImage: "info.bubble")
                                }
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    viewModel.deleteObject(textData: textData)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    })
                }

                Spacer(minLength: 150)
                    .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)
            .listStyle(.sidebar)
            .listRowSpacing(10)
            .shadow(radius: 1)

            Button(action: {
                viewModel.showAddNewTextOptionsView.toggle()
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
        NavigationLink(value: viewModel.navigationState.targetDestination) {
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
     HomeView(modelContext: DataCoordinator().persistantContainer.mainContext, showTabView: .constant(true))
        .modelContainer(for: TextData.self)
 }
