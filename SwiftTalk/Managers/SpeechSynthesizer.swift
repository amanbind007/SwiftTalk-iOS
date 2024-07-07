//
//  SpeechManager.swift
//  SwiftTalk
//
//  Created by Aman Bind on 10/04/24.
//

import AVFAudio
import Foundation
import SwiftUI

enum SpeechState {
    case speaking
    case paused
    case stop
}

@Observable
class SpeechSynthesizer: NSObject {
    let synthesizer: AVSpeechSynthesizer
    
    var textFieldText: String = ""
    var textFieldAttributedString: NSAttributedString = .init()
    
    var highlightedRange: NSRange?
    var speechState = SpeechState.stop
    
    var currentlyPlayingVoice: String?
    
    // to track highligh stating point if user tapped on the text
    var startIndex: Int = 0
    
    @ObservationIgnored @AppStorage("voiceSpeed") var voiceSpeedSliderValue = 1.0
    @ObservationIgnored @AppStorage("voicePitch") var voicePitchSliderValue = 1.0
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
    
    func play(text: String, voice: String, from startIndex: Int = 0) {
        stopSpeakingText()
        speechState = .speaking
        self.startIndex = startIndex
        if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            let textToSpeak = String(text.dropFirst(startIndex))
            let utterance = AVSpeechUtterance(string: textToSpeak)
            utterance.voice = AVSpeechSynthesisVoice(language: language)
            utterance.rate = Float(voiceSpeedSliderValue)
            utterance.pitchMultiplier = Float(voicePitchSliderValue)
            synthesizer.speak(utterance)
        }
    }
    
    func pauseSpeaking() {
        synthesizer.pauseSpeaking(at: .immediate)
        speechState = .paused
    }
    
    func continueSpeaking() {
        synthesizer.continueSpeaking()
        speechState = .speaking
    }
    
    func stopSpeakingText() {
        synthesizer.stopSpeaking(at: .immediate)
        speechState = .stop
    }
}

extension SpeechSynthesizer: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        speechState = .paused
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        speechState = .stop
        highlightedRange = NSRange(location: 0, length: 0)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        speechState = .stop
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        speechState = .speaking
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        speechState = .speaking
        highlightedRange = NSRange(location: 0, length: 0)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        let adjustedRange = NSRange(location: characterRange.location + startIndex, length: characterRange.length)
        highlightedRange = adjustedRange
    }
}
