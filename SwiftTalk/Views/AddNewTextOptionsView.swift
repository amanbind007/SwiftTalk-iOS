//
//  AddNewTextOptionsView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 11/03/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct AddNewTextOptionsView: View {
    @Environment(\.dismiss) var dismiss

    @Binding var navigationState: NavigationStateViewModel
    @Binding var showAddNewTextOptionsView: Bool

    @State var viewModel = AddNewTextOptionsViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(TextSource.allCases) { option in
                    Button(action: {
                        switch option {
//                        case .camera:
//                            break
                        case .photoLibrary:
                            viewModel.showImagePickerSheet = true
                        case .wordDocument:
                            viewModel.fileType = .doc
                            viewModel.showFileImporterSheet = true
                        case .textInput:
                            self.showAddNewTextOptionsView = false

                            self.navigationState.targetDestination.append(option)
                        case .pdfDocument:
                            viewModel.fileType = .pdf
                            viewModel.showFileImporterSheet = true
                        case .webpage:
                            viewModel.showWebTextSheet = true
                        case .textFile:
                            viewModel.fileType = .text
                            viewModel.showFileImporterSheet = true
                        }

                    }) {
                        AddNewTextOptionCardView(title: option.title, description: option.description, imageName: option.imageName)
                    }
                }
            }

            .fileImporter(
                isPresented: $viewModel.showFileImporterSheet,
                allowedContentTypes: viewModel.fileType?.allowedContentType ?? []
            ) { result in
                do {
                    let url = try result.get()
                    viewModel.convertFileToText(documentURL: url)
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
                    .font(NotoFont.Regular(16))
                }
            })
            .sheet(isPresented: $viewModel.showWebTextSheet, content: {
                WebLinkTextSheetView(addNewTextOptionsVM: $viewModel, showAddNewTextOptionsView: $showAddNewTextOptionsView, showWebTextSheet: $viewModel.showWebTextSheet)
                    .presentationDetents([.height(280)])
            })
            .sheet(isPresented: $viewModel.showImagePickerSheet, content: {
                ImagePicker(showImagePickerSheet: $viewModel.showImagePickerSheet, addNewTextOptionsVM: $viewModel, showAddNewTextOptionsView: $showAddNewTextOptionsView)
                    .ignoresSafeArea(edges: .bottom)
            })
            .alert(isPresented: $viewModel.showParseAlert, content: {
                Alert(title: Text("Error!"), message: Text(viewModel.errorMessage ?? "Could'nt parse the text"), dismissButton: .default(Text("OK")))
            })
        }
    }
}

#Preview {
    AddNewTextOptionsView(navigationState: .constant(NavigationStateViewModel()), showAddNewTextOptionsView: .constant(true))
}
