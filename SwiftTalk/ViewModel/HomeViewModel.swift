//
//  HomeViewModel.swift
//  SwiftTalk
//
//  Created by Aman Bind on 27/08/24.
//

import Foundation
import Observation
import SwiftData

@Observable
class HomeViewModel {
    var showAddNewTextOptionsView = false
    var searchText: String = ""
    var navigationState = NavigationStateViewModel()
    var showTitleUpdateAlert: Bool = false
    var showInfoCardView: Bool = false
    var showSettingsView: Bool = false
    var newTitle: String = ""
    var selectedTextData: TextData?
    var isCorrect: Bool = true
    var textDatas: [TextData]
    var selectedSortOrder: SortOrder = .recent

    var filteredAndSortedTextData: [TextData] {
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

    init(textDatas: [TextData]) {
        self.textDatas = textDatas
    }
}
