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
    
    @Binding var viewModel: NavigationStateViewModel
    @Binding var addNewTextVM: AddNewTextViewModel

    @State var showWebTextSheet: Bool = false
    @State var showImagePickerSheet: Bool = false
    @State var showPDFFileImporterSheet: Bool = false
    @State var showDocFileImporterSheet: Bool = false

    let docUTType = UTType(importedAs: "com.amanbind.swifttalk.doc", conformingTo: .data)

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
                            self.viewModel.showAddNewTextOptionsView = false
                            self.viewModel.targetDestination.append(option)
                        case .pdfDocument:
                            showPDFFileImporterSheet.toggle()
                        case .webpage:
                            showWebTextSheet.toggle()
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
                }
            })
            .sheet(isPresented: $showWebTextSheet, content: {
                WebLinkTextSheetView()
                    .presentationDetents([.height(260)])
            })

            .sheet(isPresented: $showImagePickerSheet, content: {
                ZStack {
                    ImagePickerView(showImagePickerSheet: $showImagePickerSheet, addNewTextVM: $addNewTextVM, viewModel: $viewModel)
                        .ignoresSafeArea(edges: .bottom)

                    if addNewTextVM.isProcessingImages {
                        Color.white.opacity(0.5)

                        ProgressView()
                            .frame(width: .infinity, height: .infinity)
                    }
                }
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
            .fileImporter(isPresented: $showDocFileImporterSheet, allowedContentTypes: [docUTType]) { result in

                do {
                    let url = try result.get()
                    addNewTextVM.convertDocToText(yourDocumentURL: url)
                }
                catch {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    AddNewTextOptionsView(viewModel: .constant(NavigationStateViewModel()), addNewTextVM: .constant(AddNewTextViewModel()))
}
