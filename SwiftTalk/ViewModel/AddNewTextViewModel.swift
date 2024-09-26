//
//  AddNewTextViewModel.swift
//  SwiftTalk
//
//  Created by Aman Bind on 08/04/24.
//

import Foundation
import SwiftUI


@Observable
class AddNewTextViewModel {
    var isPlaying = false
    var isVoiceSelectorPresented = false
    var isVoiceSpeedSelectorPresented = false
    let pasteboard = UIPasteboard.general
}
