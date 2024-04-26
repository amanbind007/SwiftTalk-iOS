//
//  AddNewTextOptionsView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 11/03/24.
//

import PhotosUI
import SwiftUI

struct AddNewTextOptionsView: View {
    let viewModel: NavigationStateViewModel
    @State private var selectedOption: AddNewTextOption?

    @State var showWebTextSheet: Bool = false
    @State var showImagePickerSheet: Bool = false
    @State var showPDFFileImporterSheet: Bool = false
    @State var showDocFileImporterSheet: Bool = false

    @State var addNewTextVM = AddNewTextViewModel()

    let docUTType = UTType(importedAs: "com.amanbind.swifttalk.doc" , conformingTo: .data)

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer(minLength: 44)
                    // List of Options for adding text

                    ScrollView {
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
                                    .padding([.top], 2)
                            }
                        }
                        .offset(y: 8)
                        Spacer()
                    }
                    .background(
                        Color.accent2
                    )
                }
                .sheet(isPresented: $showWebTextSheet, content: {
                    WebLinkTextSheetView()
                        .presentationDetents([.height(260)])
                })
                .sheet(isPresented: $showImagePickerSheet, content: {
                    ImagePickerView(selectedImages: $addNewTextVM.selectedImages, showImagePickerSheet: $showImagePickerSheet, viewModel: viewModel)
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
                .fileImporter(isPresented: $showDocFileImporterSheet, allowedContentTypes: [docUTType]) { result in

                    do {
                        let url = try result.get()
                        addNewTextVM.convertDocToText(yourDocumentURL: url)
                    }
                    catch {
                        print(error)
                    }
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

#Preview {
    AddNewTextOptionsView(viewModel: NavigationStateViewModel())
}
