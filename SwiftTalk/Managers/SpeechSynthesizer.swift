//
//  SpeechManager.swift
//  SwiftTalk
//
//  Created by Aman Bind on 10/04/24.
//

import Foundation
import AVFAudio
import SwiftUI


class SpeechSynthesizer: NSObject, AVSpeechSynthesizerDelegate {
    
    @Environment(AddNewTextViewModel.self) var addNewTextVM

    let synthesizer = AVSpeechSynthesizer()
    
    func play(){
        if addNewTextVM.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            
        }
    }
    
    
    
}
