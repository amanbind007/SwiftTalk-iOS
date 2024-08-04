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

            .navigationTitle("SwiftTalk")
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always)
            )

//            .toolbarBackground(.visible, for: .navigationBar)
//            .toolbarBackground(.accent2, for: .navigationBar)
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

extension HomeView {
    @ViewBuilder
    var EmptyHomeView: some View {
        ZStack {
            LinearGradient(colors: [Color(#colorLiteral(red: 0.02420473658, green: 0.08916769177, blue: 0.1760105193, alpha: 1)), Color(#colorLiteral(red: 0.05882352941, green: 0.06666666667, blue: 0.07450980392, alpha: 1))], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                LottieView(animation: .named("EmptyAnimation"))
                    .playing(loopMode: .loop)
                    .frame(height: 300)

                Text("I have nothing speak!")

                Button {
                    showAddNewTextOptionsView.toggle()
                } label: {
                    Text("Add some new Text to Read")
                        .font(.custom(Constants.Fonts.NotoSerifSB, size: 18))
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
                .listRowBackground(Color(red: 0.075, green: 0.294, blue: 0.439))
            }
            .scrollContentBackground(.hidden)
            .listStyle(.sidebar)
            .listRowSpacing(10)
            

            Button(action: {
                showAddNewTextOptionsView.toggle()
            }, label: {
                Circle()
                    .frame(width: 55, height: 55)
                    .foregroundStyle(Color.green)
                    .overlay {
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundStyle(.black)
                            .padding(15)
                    }

            })
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(1), radius: 10, x: -7, y: -7)
            .padding()
        }
        .background(
            LinearGradient(colors: [Color(#colorLiteral(red: 0.02420473658, green: 0.08916769177, blue: 0.1760105193, alpha: 1)), Color(#colorLiteral(red: 0.05882352941, green: 0.06666666667, blue: 0.07450980392, alpha: 1))], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
    }
}

extension HomeView {
    @ViewBuilder
    var OpenAddNewTextView: some View {
        NavigationLink(value: navigationState.targetDestination) {
            EmptyView()
        }
        .navigationDestination(for: TextSource.self) { target in
            if target == .textInput {
                AddNewTextView(textData: TextData(textTitle: nil, text: "", textSource: .textInput), isEditing: true, isFocused: true, isSaved: false)
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: TextData.self)
}
