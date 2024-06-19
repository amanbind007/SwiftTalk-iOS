//
//  SpeechManager.swift
//  SwiftTalk
//
//  Created by Aman Bind on 10/04/24.
//

import AVFAudio
import Foundation
import SwiftUI

@Observable
class SpeechSynthesizer: NSObject {
    let synthesizer: AVSpeechSynthesizer
    
    var textFieldText: String = ""
    var textFieldAttributedString: NSAttributedString = .init()
    
    var highlightedRange = NSRange(location: 0, length: 0)
    var isSpeaking = false
    
    var currentlyPlayingVoice: String?
    
    // to track highligh stating point if user tapped on the text
    var startIndex: Int = 0
    
    @ObservationIgnored @AppStorage("language") var language = "en-US"
    
    override init() {
        synthesizer = AVSpeechSynthesizer()
        
        super.init()
        
        synthesizer.delegate = self
    }
    
    func playDemo(text: String, voice: String, languageCode: String) {
        stopDemo()
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(identifier: voice)
        utterance.rate = 0.5
        synthesizer.speak(utterance)
        currentlyPlayingVoice = voice
    }
        
    func stopDemo() {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        currentlyPlayingVoice = nil
    }

    func play(text: String, voice: String) {
        if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            print(text)
            let utterrence = AVSpeechUtterance(string: text)
            utterrence.voice = AVSpeechSynthesisVoice(language: language)

            synthesizer.speak(utterrence)
            synthesizer.pauseSpeaking(at: .immediate)
            isSpeaking = true
        }
    }
    
    func play(text: String, voice: String, from startIndex: Int = 0) {
        stopSpeakingText()
        self.startIndex = startIndex
        if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            let textToSpeak = String(text.dropFirst(startIndex))
            let utterance = AVSpeechUtterance(string: textToSpeak)
            utterance.voice = AVSpeechSynthesisVoice(language: language)
            synthesizer.speak(utterance)
            isSpeaking = true
        }
    }
    
    func pauseText() {
        synthesizer.pauseSpeaking(at: .immediate)
        isSpeaking = false
    }
    
    func continueSpeaking() {
        synthesizer.continueSpeaking()
        isSpeaking = true
    }
    
    func stopSpeakingText() {
        synthesizer.stopSpeaking(at: .immediate)
        isSpeaking = false
    }
}

extension SpeechSynthesizer: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {}
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isSpeaking = false
        highlightedRange = NSRange(location: 0, length: 0)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {}
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {}
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        highlightedRange = NSRange(location: 0, length: 0)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        let adjustedRange = NSRange(location: characterRange.location + startIndex, length: characterRange.length)
        highlightedRange = adjustedRange
    }
}
