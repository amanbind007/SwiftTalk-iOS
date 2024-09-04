//
//  HomeViewModel.swift
//  SwiftTalk
//
//  Created by Aman Bind on 27/08/24.
//

import Foundation
import Observation
import SwiftData
import SwiftUI

@Observable
class HomeViewModel {
    var searchText: String = ""
    var showAddNewTextOptionsView = false
    var navigationState = NavigationStateViewModel()
    var showTitleUpdateAlert: Bool = false
    var showInfoCardView: Bool = false
    var showSettingsView: Bool = false
    var showReminderView: Bool = false
    var newTitle: String = ""
    var selectedTextData: TextData?
    var isCorrect: Bool = true

    @ObservationIgnored @AppStorage("sortOrder") var selectedSortOrder: SortOrder = .recent

    private var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func filteredAndSortedTextData(_ textDatas: [TextData]) -> [TextData] {
        var filteredTextData = textDatas

        // Apply Filter
        if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            filteredTextData = textDatas.filter { textData in
                textData.textTitle!.contains(searchText.lowercased()) ||
                    textData.text.lowercased().contains(searchText.lowercased())
            }
        }

        // Apply Sort
        switch selectedSortOrder {
        case .recent:
            filteredTextData.sort { $0.lastAccess > $1.lastAccess }
        case .dateLowToHigh:
            filteredTextData.sort { $0.creationDateTime < $1.creationDateTime }
        case .dateHighToLow:
            filteredTextData.sort { $0.creationDateTime > $1.creationDateTime }
        case .AtoZ:
            filteredTextData.sort { $0.textTitle! < $1.textTitle! }
        case .ZtoA:
            filteredTextData.sort { $0.textTitle! > $1.textTitle! }
        }

        return filteredTextData
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
