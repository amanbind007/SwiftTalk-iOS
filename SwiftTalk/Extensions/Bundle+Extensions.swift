//
//  Bundle+Extensions.swift
//  SwiftTalk
//
//  Created by Aman Bind on 10/09/24.
//

import Foundation

extension Bundle {
    
    public var appVersionShort: String {
        guard let result = infoDictionary?["CFBundleShortVersionString"] as? String else {return ""}
        return result
    }
    
    public var appVersionLong: String {
        guard let result = infoDictionary?["CFBundleVersion"] as? String else {return ""}
        return result
    }
}
