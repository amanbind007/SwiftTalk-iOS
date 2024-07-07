//
//  AddNewTextViewModel.swift
//  SwiftTalk
//
//  Created by Aman Bind on 08/04/24.
//

import Foundation
import OfficeFileReader
import PDFKit
import SwiftSoup
import SwiftUI
import UIKit
import UniformTypeIdentifiers
import Vision

@Observable
class AddNewTextViewModel {
    var isPlaying = false
    var isVoiceSelectorPresented = false
    var isVoiceSpeedSelectorPresented = false
    let pasteboard = UIPasteboard.general
}
