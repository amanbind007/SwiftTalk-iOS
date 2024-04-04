//
//  AddNewTextOptionsView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 11/03/24.
//

import SwiftUI

struct AddNewTextOptionsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    // Track selected option
    @State private var selectedOption: AddNewTextOption?
    
    @Binding var showAddNewTextOptionsView : Bool

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer(minLength: 44)
                    // List of Options for adding text
                    ScrollView {
                        ForEach(AddNewTextOption.allCases) { option in
                            Button(action: {
                                // self.dismiss()
                                self.selectedOption = option
                                // Call function to close sheet and present new view

                                self.closeSheetAndPresentNewView()
                            }) {
                                AddNewTextOptionCardView(title: option.title, description: option.description, imageName: option.imageName)
                                    .padding([.top], 2)
                            }
                            .tag(option)
                        }
                        .offset(y: 8)
                        Spacer()
                    }
                    .background(
                        Color.accent2
                    )
                }

                // Custom Top Bar View
                VStack {
                    VStack {
                        HStack {
                            Text("Add Text")
                                .font(.custom(Constants.Fonts.AbrilFatfaceR, size: 20))
                                .offset(y: 10)
                        }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(
                                LinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing)
                            )
                    }
                    .background(Material.ultraThin)

                    Spacer()
                }
            }
        }
    }

    func closeSheetAndPresentNewView() {
        if let option = selectedOption {
            if #available(iOS 15.0, *) {
                presentationMode.wrappedValue.dismiss()
            } else {
                presentationMode.wrappedValue.dismiss()
            }
            // Present new view based on option
            switch option {
            case .camera:
                // Present AddNewTextView for camera
                NavigationLink(destination: AddNewTextView()) { EmptyView() }
            case .photoLibrary:
                // Present AddNewTextView for Photo Library
                NavigationLink(destination: AddNewTextView()) { EmptyView() }
            // ... and so on for other options
            case .wordDocument:
                NavigationLink(destination: AddNewTextView()) { EmptyView() }
            case .textInput:
                NavigationLink(destination: AddNewTextView()) { EmptyView() }
            case .pdfDocument:
                NavigationLink(destination: AddNewTextView()) { EmptyView() }
            case .webpage:
                NavigationLink(destination: AddNewTextView()) { EmptyView() }
            }
        }
    }
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

#Preview {
    AddNewTextOptionsView()
}
