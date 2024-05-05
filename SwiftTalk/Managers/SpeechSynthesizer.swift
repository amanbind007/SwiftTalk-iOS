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
    private let synthesizer: AVSpeechSynthesizer
    
    
    override init() {
        synthesizer = AVSpeechSynthesizer()
        
        super.init()
        
        synthesizer.delegate = self
    }

    @ObservationIgnored @AppStorage("language") var language = "en-US"

    func play(text: String, voice: String) {
        if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            print(text)
            let utterrence = AVSpeechUtterance(string: text)
            utterrence.voice = AVSpeechSynthesisVoice(language: language)

            synthesizer.speak(utterrence)
            synthesizer.pauseSpeaking(at: .immediate)
            print(text)
        }
    }
    
    func pauseText() {
        synthesizer.pauseSpeaking(at: .immediate)
    }
    
    func continueSpeaking() {
        synthesizer.continueSpeaking()
    }
    
    func stopSpeakingText() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}

extension SpeechSynthesizer: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        // let rangeString = Range(characterRange, in: utterance.speechString)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {}
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {}
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {}
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {}
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {}
}
