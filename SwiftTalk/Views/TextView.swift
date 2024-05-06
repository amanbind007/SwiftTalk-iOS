//
//  TextArea.swift
//  SwiftTalk
//
//  Created by Aman Bind on 06/05/24.
//

import Foundation
import SwiftUI
import UIKit

struct TextView: UIViewRepresentable {
    func makeCoordinator() -> TextViewCoordinator {
        TextViewCoordinator(parent: self)
    }

    func makeUIView(context: Context) -> some UITextView {
        let textView = UITextView()
        
        return textView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

class TextViewCoordinator: NSObject, UITextViewDelegate {
    let parent: TextView

    init(parent: TextView) {
        self.parent = parent
    }
}
