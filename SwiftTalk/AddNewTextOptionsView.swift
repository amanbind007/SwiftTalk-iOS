//
//  AddNewTextOptionsView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 11/03/24.
//

import SwiftUI

struct AddNewTextOptionsView: View {
    // Track selected option
    @State private var selectedOption: AddNewTextOption?

    var body: some View {
        NavigationStack {
            ZStack {
                
                VStack{
                    Spacer(minLength: 44)
                    // List of Options for adding text
                    ScrollView {
                        ForEach(AddNewTextOption.allCases) { option in
                            NavigationLink {
                                switch option {
                                case .camera:
                                    AddNewTextView()
                                    // Some View For getting text from camera
                                case .photoLibrary:
                                    AddNewTextView()
                                    // Some View to get text from Photo Library
                                case .wordDocument:
                                    AddNewTextView()
                                    // Some View to get text from Word Doc
                                case .textInput:
                                    AddNewTextView()
                                case .pdfDocument:
                                    AddNewTextView()
                                    // Some View to get text from PDFs
                                case .webpage:
                                    AddNewTextView()
                                    // Some View to get text from Webpage
                                }
                            } label: {
                                AddNewTextOptionCardView(title: option.title, description: option.description, imageName: option.imageName)
                                    .padding([.top], 2)
                            }
                            .tag(option) // Assign unique tag for identification
                        }
                        .offset(y:8)
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
