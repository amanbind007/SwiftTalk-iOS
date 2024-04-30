//
//  AddNewTextOptionsView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 11/03/24.
//

import PhotosUI
import SwiftUI

struct AddNewTextOptionsView: View {
    @Environment(\.dismiss) var dismiss

    @Binding var navigationState: NavigationStateViewModel
    @Bindable var addNewTextVM: AddNewTextViewModel

    @State var showWebTextSheet: Bool = false
    @State var showImagePickerSheet: Bool = false
    @State var showPDFFileImporterSheet: Bool = false
    @State var showDocFileImporterSheet: Bool = false
    @State var showTextFileImporterSheet: Bool = false

    let docUTType = UTType(importedAs: "com.amanbind.swifttalk.doc", conformingTo: .data)
    let docxUTType = UTType(importedAs: "com.amanbind.swifttalk.docx", conformingTo: .data)
    

    var body: some View {
        NavigationView {
            List {
                ForEach(AddNewTextOption.allCases) { option in
                    Button(action: {
                        switch option {
                        case .camera:
                            break
                        case .photoLibrary:
                            showImagePickerSheet.toggle()
                        case .wordDocument:
                            showDocFileImporterSheet.toggle()
                        case .textInput:
                            self.navigationState.showAddNewTextOptionsView = false
                            self.navigationState.targetDestination.append(option)
                        case .pdfDocument:
                            showPDFFileImporterSheet.toggle()
                        case .webpage:
                            showWebTextSheet.toggle()
                        case .textFile:
                            showTextFileImporterSheet.toggle()
                        }

                    }) {
                        AddNewTextOptionCardView(title: option.title, description: option.description, imageName: option.imageName)
                    }
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
                WebLinkTextSheetView(addNewTextVM: addNewTextVM)
                    .presentationDetents([.height(260)])
            })
            .sheet(isPresented: $showImagePickerSheet, content: {
                ImagePickerView(showImagePickerSheet: $showImagePickerSheet, addNewTextVM: addNewTextVM, navigationState: $navigationState)
                    .ignoresSafeArea(edges: .bottom)
            })
            .fileImporter(isPresented: $showPDFFileImporterSheet, allowedContentTypes: [.pdf]) { result in

                do {
                    let url = try result.get()
                    addNewTextVM.convertPDFToText(yourDocumentURL: url)
                }
                catch {
                    print(error)
                }
            }
            .fileImporter(isPresented: $showDocFileImporterSheet, allowedContentTypes: [docUTType, docxUTType]) { result in

                do {
                    let url = try result.get()
                    addNewTextVM.convertDocToText(yourDocumentURL: url)
                }
                catch {
                    print(error)
                }
            }
            .fileImporter(isPresented: $showTextFileImporterSheet, allowedContentTypes: [.text, .plainText, .utf8PlainText]) { result in
                do {
                    let url = try result.get()
                    addNewTextVM.getTextFromTextFile(textFile: url)
                }
                catch {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    AddNewTextOptionsView(navigationState: .constant(NavigationStateViewModel()), addNewTextVM: AddNewTextViewModel())
}
