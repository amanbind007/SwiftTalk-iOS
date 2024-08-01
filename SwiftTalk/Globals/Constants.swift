//
//  Constants.swift
//  SwiftTalk
//
//  Created by Aman Bind on 12/03/24.
//

import Foundation

struct Constants {
    enum Fonts {
        static let NotoSerifSB = "NotoSerif-SemiBold"
        static let NotoSerifR = "NotoSerif-Regular"

        static let NotoRegular = "NotoSerif-Regular"
        static let NotoLight = "NotoSerif-Regular_ExtraLight"
        static let NotoSemiBold = "NotoSerif-SemiBold"
        static let NotoBold = "NotoSerif-Regular_Bold"

        static let NotoRegularItalic = "NotoSerif-Italic"
        static let NotoLightItalic = "NotoSerif-Italic_ExtraLight-Italic"
        static let NotoSemiBoldItalic = "NotoSerif-Italic_SemiBold-Italic"
        static let NotoBoldItalic = "NotoSerif-Italic_Bold-Italic"
    }

    enum BionicFonts {
        static let BionicSans = "Fast_Sans"
        static let BionicSerif = "Fast_Serif"

        static let allFonts: [String] = [
            BionicSans,
            BionicSerif
        ]
    }

    enum OpenDislexic {
        static let OpenDyslexicBoldItalic = "OpenDyslexic-Bold-Italic"
        static let OpenDyslexicBold = "OpenDyslexic-Bold"
        static let OpenDyslexicItalic = "OpenDyslexic-Italic"
        static let OpenDyslexicRegular = "OpenDyslexic-Regular"

        static let allFonts: [String] = [
            OpenDyslexicBoldItalic,
            OpenDyslexicBold,
            OpenDyslexicItalic,
            OpenDyslexicRegular
        ]
    }

    enum Icons {
        static let cameraIcon = "camera_icon"
        static let imageFileIcon = "image_file_icon"
        static let linkIcon = "link_icon"
        static let pdfFileIcon = "pdf_file_icon"
        static let textFileIcon = "text_file_icon"
        static let textFileInputIcon = "text_input_file_icon"
        static let webIcon = "web_icon"
        static let wordFileIcon = "word_file_icon"
    }
}
