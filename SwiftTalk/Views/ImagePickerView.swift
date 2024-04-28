//
//  ImagePickerView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 28/04/24.
//

import SwiftUI

struct ImagePickerView: View {
    

    @Binding var showImagePickerSheet: Bool
    @Bindable var addNewTextVM: AddNewTextViewModel
    @Binding var navigationState: NavigationStateViewModel

    var body: some View {
        ZStack {
            ImagePicker(showImagePickerSheet: $showImagePickerSheet, addNewTextVM: addNewTextVM, viewModel: $navigationState)
                .ignoresSafeArea(edges: .bottom)

            if addNewTextVM.isProcessingImages {
                Color.white.opacity(0.5)

                ProgressView()
                    .frame(width: .infinity, height: .infinity)
            }
        }
    }
}

#Preview {
    ImagePickerView(showImagePickerSheet: .constant(true), addNewTextVM: AddNewTextViewModel(), navigationState: .constant(NavigationStateViewModel()))
}
