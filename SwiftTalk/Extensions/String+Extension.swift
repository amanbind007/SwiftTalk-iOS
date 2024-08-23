//
//  String+Extension.swift
//  SwiftTalk
//
//  Created by Aman Bind on 20/07/24.
//

import Foundation

extension String {
    func trimEndWhitespaceAndNewlines() -> String {
        let charactersToTrim = CharacterSet.whitespacesAndNewlines
        var trimmedString = self

        while let lastChar = trimmedString.last,
              String(lastChar).rangeOfCharacter(from: charactersToTrim) != nil
        {
            trimmedString = String(trimmedString.dropLast())
        }

        return trimmedString
    }

    func stringRange(_ range: NSRange) -> String {
        guard let swiftRange = Range(range, in: self) else {
            return ""
        }
        return String(self[swiftRange])
    }
}
