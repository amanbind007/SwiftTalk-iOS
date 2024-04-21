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

    @State var addNewTextVM = AddNewTextViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer(minLength: 44)
                    // List of Options for adding text

                    ScrollView {
                        ForEach(AddNewTextOption.allCases) { option in
                            Button(action: {
                                if option == .webpage {
                                    showWebTextSheet.toggle()
                                }
                                else if option == .photoLibrary {
                                    showImagePickerSheet.toggle()
                                }
                                else {
                                    self.viewModel.showAddNewTextOptionsView = false
                                    self.viewModel.targetDestination.append(option)
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
                    ImagePickerView(selectedImages: $addNewTextVM.selectedImages, showimagePickerSheet: $showImagePickerSheet)
                        .ignoresSafeArea(edges: .bottom)
                })

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
