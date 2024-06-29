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
    @Binding var showAddNewTextOptionsView: Bool

    var body: some View {
        ZStack {
            ImagePicker(showImagePickerSheet: $showImagePickerSheet, addNewTextVM: addNewTextVM, showAddNewTextOptionsView: $showAddNewTextOptionsView)
                .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    ImagePickerView(
        showImagePickerSheet: .constant(true),
        addNewTextVM: AddNewTextViewModel(),
        showAddNewTextOptionsView: .constant(true)
    )
}
