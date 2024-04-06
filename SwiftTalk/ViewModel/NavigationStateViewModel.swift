//
//  NavigationStateViewModel.swift
//  SwiftTalk
//
//  Created by Aman Bind on 04/04/24.
//

import Foundation

@Observable
class NavigationStateViewModel {
    var showAddNewTextOptionsView = false
    var targetDestination: [AddNewTextOption] = []
}

enum AddNewTextOption: String, CaseIterable, Identifiable {
    case camera = "Camera Scan"
    case photoLibrary = "Photo Library"
    case wordDocument = "Word Documents"
    case textInput = "Text"
    case pdfDocument = "PDF Documents"
    case webpage = "Webpage"

    var id: String { self.rawValue }

    var title: String { self.rawValue }
    var description: String {
        switch self {
        case .camera: return "Scan physical text using your camera"
        case .photoLibrary: return "Get text from the photos in your library"
        case .wordDocument: return "Add documents from your local storage or cloud"
        case .textInput: return "Input or paste text to read"
        case .pdfDocument: return "Add PDFs from your local storage or cloud"
        case .webpage: return "Listen to the contents of a webpage"
        }
    }

    var imageName: String {
        switch self {
        case .camera: return Constants.Icons.cameraIcon
        case .photoLibrary: return Constants.Icons.imageFileIcon
        case .wordDocument: return Constants.Icons.wordFileIcon
        case .textInput: return Constants.Icons.textFileInputIcon
        case .pdfDocument: return Constants.Icons.pdfFileIcon
        case .webpage: return Constants.Icons.webIcon
        }
    }
}
