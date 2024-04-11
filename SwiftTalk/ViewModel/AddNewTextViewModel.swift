//
//  AddNewTextViewModel.swift
//  SwiftTalk
//
//  Created by Aman Bind on 08/04/24.
//

import Foundation
import SwiftUI
import UIKit

@Observable
class AddNewTextViewModel {
    var isPlaying = false
    var isVoiceSelectorPresented = false
    var isVoiceSpeedSelectorPresented = false
    var degreesRotating = 0.0

    let pasteboard = UIPasteboard.general

    var title = ""
    var text = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce iaculis interdum ex. Donec faucibus orci purus, at sagittis lorem placerat at. Morbi sodales porta massa in blandit. Cras eget varius lacus. Cras ac libero quis velit semper dapibus. Maecenas viverra mauris nec maximus egestas. In hac habitasse platea dictumst. Quisque hendrerit scelerisque lorem sit amet pellentesque. Mauris luctus ipsum in pharetra finibus. Sed rutrum finibus dui. Mauris ullamcorper ut ante vel congue. Nullam ac justo sagittis, tincidunt velit id, consequat velit. Vivamus purus turpis, condimentum eu blandit nec, ullamcorper et erat. Fusce velit eros, ornare at lectus quis, interdum varius urna.
    """
}
