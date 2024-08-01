//
//  NotoFont.swift
//  SwiftTalk
//
//  Created by Aman Bind on 31/07/24.
//

import Foundation
import SwiftUI

struct NotoFont {
    static func Regular(_ size: CGFloat) -> Font {
        return Font.custom(Constants.Fonts.NotoRegular, size: size)
    }

    static func Light(_ size: CGFloat) -> Font {
        return Font.custom(Constants.Fonts.NotoLight, size: size)
    }

    static func SemiBold(_ size: CGFloat) -> Font {
        return Font.custom(Constants.Fonts.NotoSemiBold, size: size)
    }

    static func Bold(_ size: CGFloat) -> Font {
        return Font.custom(Constants.Fonts.NotoBold, size: size)
    }

    static func RegularItalic(_ size: CGFloat) -> Font {
        return Font.custom(Constants.Fonts.NotoRegularItalic, size: size)
    }

    static func LightItalic(_ size: CGFloat) -> Font {
        return Font.custom(Constants.Fonts.NotoLightItalic, size: size)
    }

    static func SemiBoldItalic(_ size: CGFloat) -> Font {
        return Font.custom(Constants.Fonts.NotoSemiBoldItalic, size: size)
    }

    static func Bolditalic(_ size: CGFloat) -> Font {
        return Font.custom(Constants.Fonts.NotoBoldItalic, size: size)
    }
}
