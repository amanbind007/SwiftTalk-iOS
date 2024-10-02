//
//  Text+Extension.swift
//  SwiftTalk
//
//  Created by Aman Bind on 02/10/24.
//

import SwiftUI

extension Text {
    init(_ string: String, configure: (inout AttributedString) -> Void) {
        var attributedString = AttributedString(string) /// create an `AttributedString`
        configure(&attributedString) /// configure using the closure
        self.init(attributedString) /// initialize a `Text`
    }
}
