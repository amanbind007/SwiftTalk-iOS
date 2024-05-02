//
//  SpeechManager.swift
//  SwiftTalk
//
//  Created by Aman Bind on 10/04/24.
//

import AVFAudio
import Foundation
import SwiftUI

class SpeechSynthesizer: NSObject, AVSpeechSynthesizerDelegate {
    let synthesizer = AVSpeechSynthesizer()

    @AppStorage("language") var language = "en-US"

    func playPause(text: String, voice: String) {
        if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            print(text)
            let utterrence = AVSpeechUtterance(string: text)
            utterrence.voice = AVSpeechSynthesisVoice(language: language)

            synthesizer.speak(utterrence)
            print(text)
        }
    }
}
