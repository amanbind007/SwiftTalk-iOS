//
//  AddNewTextOptionsView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 11/03/24.
//

import SwiftUI
import UniformTypeIdentifiers

enum FileImportTypes {
    case text
    case doc
    case pdf

    var allowedContentType: [UTType] {
        switch self {
        case .text:
            return [.text, .plainText, .utf8PlainText]
        case .doc:
            return [UTType(importedAs: "com.amanbind.swifttalk.doc", conformingTo: .data)]
        case .pdf:
            return [.pdf]
        }
    }
}

struct AddNewTextOptionsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @Binding var navigationState: NavigationStateViewModel
    @Binding var showAddNewTextOptionsView: Bool

    @State var addNewTextOptionsVM = AddNewTextOptionsViewModel()
    @State var showWebTextSheet: Bool = false
    @State var showImagePickerSheet: Bool = false
    @State var showFileImporterSheet: Bool = false
    @State var fileType: FileImportTypes?

    let docUTType = UTType(importedAs: "com.amanbind.swifttalk.doc", conformingTo: .data)

    var body: some View {
        NavigationView {
            List {
                ForEach(TextSource.allCases) { option in
                    Button(action: {
                        switch option {
//                        case .camera:
//                            break
                        case .photoLibrary:
                            showImagePickerSheet = true
                        case .wordDocument:
                            fileType = .doc
                            showFileImporterSheet = true
                        case .textInput:
                            self.showAddNewTextOptionsView = false

                            self.navigationState.targetDestination.append(option)
                        case .pdfDocument:
                            fileType = .pdf
                            showFileImporterSheet = true
                        case .webpage:
                            showWebTextSheet = true
                        case .textFile:
                            fileType = .text
                            showFileImporterSheet = true
                        }

                    }) {
                        AddNewTextOptionCardView(title: option.title, description: option.description, imageName: option.imageName)
                    }
                }
                .listRowBackground(Color.accent1)
            }
            .scrollContentBackground(.hidden)

            .fileImporter(
                isPresented: $showFileImporterSheet,
                allowedContentTypes: fileType?.allowedContentType ?? []
            ) { result in
                do {
                    let url = try result.get()
                    addNewTextOptionsVM.convertFileToText(fileType: fileType!, documentURL: url)
                }
                catch {
                    print(error)
                }
            }
            .offset(y: -30)
            .navigationTitle("Add Text")
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(edges: .bottom)
            .toolbar(content: {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.custom(Constants.Fonts.NotoSerifR, size: 16))
                }
            })
            .sheet(isPresented: $showWebTextSheet, content: {
                WebLinkTextSheetView(addNewTextOptionsVM: $addNewTextOptionsVM, showAddNewTextOptionsView: $showAddNewTextOptionsView, showWebTextSheet: $showWebTextSheet)
                    .presentationDetents([.height(280)])
            })
            .sheet(isPresented: $showImagePickerSheet, content: {
                ImagePickerView(showImagePickerSheet: $showImagePickerSheet, addNewTextOptionsVM: $addNewTextOptionsVM, showAddNewTextOptionsView: $showAddNewTextOptionsView)
                    .ignoresSafeArea(edges: .bottom)
            })
            .background(
                LinearGradient(colors: [Color.gradiantColor2, Color.gradiantColor1], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    AddNewTextOptionsView(navigationState: .constant(NavigationStateViewModel()), showAddNewTextOptionsView: .constant(true), addNewTextOptionsVM: AddNewTextOptionsViewModel())
}
