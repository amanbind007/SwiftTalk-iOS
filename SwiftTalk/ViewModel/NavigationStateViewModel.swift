//
//  NavigationStateViewModel.swift
//  SwiftTalk
//
//  Created by Aman Bind on 04/04/24.
//

import Foundation


@Observable
class NavigationStateViewModel{
    var currentView = DifferentViews.HomeView
    
    func onViewChange(newView: DifferentViews){
        self.currentView = newView
    }
    
}


enum DifferentViews {
    case HomeView
    case AddNewTextOptionsView
    case AddNewTextView
    case VoiceSelectorView
}
