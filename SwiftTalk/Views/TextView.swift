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
    @Environment(\.colorScheme) var theme

    @Binding var text: String
    @Binding var highlightedRange: NSRange

    func makeCoordinator() -> TextViewCoordinator {
        TextViewCoordinator(parent: self)
    }

    func makeUIView(context: Context) -> some UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.text = text
        textView.font = UIFont.systemFont(ofSize: CGFloat(18), weight: .heavy)
        textView.isScrollEnabled = true
        textView.textAlignment = .left
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .sentences

        return textView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.font = UIFont.systemFont(ofSize: CGFloat(18), weight: .heavy)
        let attrStr = NSMutableAttributedString(string: text)
        
        attrStr.addAttribute(NSAttributedString.Key.font, value: UIFont(name: Constants.Fonts.NotoSerifR, size: 18)!, range: NSRange(location: 0, length: attrStr.length))


        attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: attrStr.length))
        
        attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(.green), range: highlightedRange)
        
        uiView.attributedText = attrStr
        uiView.scrollRangeToVisible(highlightedRange)
    }
}

class TextViewCoordinator: NSObject, UITextViewDelegate {
    let parent: TextView

    init(parent: TextView) {
        self.parent = parent
    }
    
    func textViewDidChange(_ textView: UITextView) {
        DispatchQueue.main.async {
            self.parent.text = textView.text
        }
    }
}

#Preview {
    TextView(text: .constant(""), highlightedRange: .constant(NSRange()))
}
