//
//  SpeechManager.swift
//  SwiftTalk
//
//  Created by Aman Bind on 10/04/24.
//

import AVFAudio
import Foundation
import SwiftUI
import MediaPlayer

enum SpeechState {
    case speaking
    case paused
    case stop
}

@Observable
class SpeechSynthesizer: NSObject {
    private var synthesizer: AVSpeechSynthesizer
    
    var textFieldText: String = ""
    var textFieldAttributedString: NSAttributedString = .init()
    
    var highlightedRange: NSRange?
    var speechState = SpeechState.stop
    
    var currentlyPlayingVoice: String?
    
    // to track highligh stating point if user tapped on the text
    var startIndex: Int = 0
    
    var currentCompletedIndex: Int = 0
    
    private var startTime: Date?
    private var endTime: Date?
    private(set) var totalPlayTime: TimeInterval = 0
    
    // Background playback properties
    private var currentText: String = ""
    private var currentTitle: String = "SwiftTalk"
    
    @ObservationIgnored @AppStorage("voiceSpeed") var voiceSpeedSliderValue = 0.5
    @ObservationIgnored @AppStorage("voicePitch") var voicePitchSliderValue = 1.0
    @ObservationIgnored @AppStorage("selectedVoice") var selectedVoiceIdentifier = "com.apple.speech.synthesis.voice.Samantha"
    
    override init() {
        synthesizer = AVSpeechSynthesizer()
        
        super.init()
        
        synthesizer.delegate = self
        setupAudioSession()
        setupRemoteCommandCenter()
    }
    
    // MARK: - Audio Session Setup
    private func setupAudioSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .spokenAudio, options: [.allowAirPlay, .allowBluetooth])
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    // MARK: - Remote Command Center Setup
    private func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        // Play command
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [weak self] _ in
            self?.continueSpeaking()
            return .success
        }
        
        // Pause command
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { [weak self] _ in
            self?.pauseSpeaking()
            return .success
        }
        
        // Stop command
        commandCenter.stopCommand.isEnabled = true
        commandCenter.stopCommand.addTarget { [weak self] _ in
            self?.stopSpeakingText()
            return .success
        }
        
        // Next/Previous commands (optional - you can implement chapter navigation)
        commandCenter.nextTrackCommand.isEnabled = false
        commandCenter.previousTrackCommand.isEnabled = false
        
        // Seeking commands
        commandCenter.skipForwardCommand.isEnabled = false
        commandCenter.skipBackwardCommand.isEnabled = false
    }
    
    // MARK: - Now Playing Info
    private func updateNowPlayingInfo() {
        var nowPlayingInfo = [String: Any]()
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = currentTitle
        nowPlayingInfo[MPMediaItemPropertyArtist] = "SwiftTalk"
        nowPlayingInfo[MPMediaItemPropertyMediaType] = MPMediaType.anyAudio.rawValue
        
        // Calculate progress
        let totalCharacters = Double(currentText.count)
        let currentProgress = Double(currentCompletedIndex + startIndex)
        let playbackRate = Double(voiceSpeedSliderValue)
        
        if totalCharacters > 0 {
            // Estimate total duration (rough calculation)
            let estimatedTotalDuration = totalCharacters * 0.1 / max(playbackRate, 0.1) // Rough estimate
            let currentTime = currentProgress * 0.1 / max(playbackRate, 0.1)
            
            nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = estimatedTotalDuration
            nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = currentTime
        }
        
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = speechState == .speaking ? playbackRate : 0.0
        
        // Optional: Add artwork
        if let image = UIImage(named: "app_icon") {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { _ in image }
        }
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    private func clearNowPlayingInfo() {
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nil
    }
    
    func playDemo(text: String, identifier: String) {
        stopDemo()
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(identifier: identifier)
        utterance.rate = 0.5
        synthesizer.speak(utterance)
        currentlyPlayingVoice = identifier
    }
        
    func stopDemo() {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        currentlyPlayingVoice = nil
    }
    
    func play(text: String, voice: String, from startIndex: Int = 0, title: String = "SwiftTalk") {
        stopSpeakingText()
        speechState = .speaking
        self.startIndex = startIndex
        self.currentText = text
        self.currentTitle = title
        
        startTime = Date() // Record start time
        totalPlayTime = 0 // Reset total play time
        
        if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            let textToSpeak = String(text.dropFirst(startIndex))
            let utterance = AVSpeechUtterance(string: textToSpeak)
            utterance.voice = AVSpeechSynthesisVoice(identifier: selectedVoiceIdentifier)
            utterance.rate = Float(voiceSpeedSliderValue)
            utterance.pitchMultiplier = Float(voicePitchSliderValue)
            synthesizer.speak(utterance)
            
            // Update now playing info
            updateNowPlayingInfo()
        }
    }
    
    func pauseSpeaking() {
        synthesizer.pauseSpeaking(at: .immediate)
        speechState = .paused
        updateTotalPlayTime()
        updateNowPlayingInfo()
    }
    
    func continueSpeaking() {
        synthesizer.continueSpeaking()
        speechState = .speaking
        updateNowPlayingInfo()
    }
    
    func stopSpeakingText() {
        synthesizer.stopSpeaking(at: .immediate)
        speechState = .stop
        updateTotalPlayTime()
        clearNowPlayingInfo()
    }
    
    private func updateTotalPlayTime() {
        if let start = startTime {
            let now = Date()
            totalPlayTime += now.timeIntervalSince(start)
            startTime = nil
        }
    }
}

extension SpeechSynthesizer: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        speechState = .paused
        updateNowPlayingInfo()
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        speechState = .stop
        highlightedRange = NSRange(location: 0, length: 0)
        updateTotalPlayTime()
        clearNowPlayingInfo()
        
        // Deactivate audio session when done
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        speechState = .stop
        updateTotalPlayTime()
        clearNowPlayingInfo()
        
        // Deactivate audio session when cancelled
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        speechState = .speaking
        startTime = Date()
        updateNowPlayingInfo()
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        speechState = .speaking
        highlightedRange = NSRange(location: 0, length: 0)
        
        // Ensure audio session is active
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to activate audio session: \(error)")
        }
        
        updateNowPlayingInfo()
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        let adjustedRange = NSRange(location: characterRange.location + startIndex, length: characterRange.length)
        highlightedRange = adjustedRange
        currentCompletedIndex = characterRange.upperBound
        
        // Update now playing info periodically for progress tracking
        updateNowPlayingInfo()
    }
}
