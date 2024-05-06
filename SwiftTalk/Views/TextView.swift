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
    @Binding var text: String

    func makeCoordinator() -> TextViewCoordinator {
        TextViewCoordinator(parent: self)
    }

    func makeUIView(context: Context) -> some UITextView {
        let textView = UITextView()
        textView.text = text
        textView.font = UIFont(name: Constants.Fonts.NotoSerifR, size: 18)
        textView.selectedRange = NSRange(location: 1, length: 3)

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

#Preview {
    TextView(text: .constant("Hello"))
}
