//
//  ImagePickerView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 28/04/24.
//

import SwiftUI

struct ImagePickerView: View {
    @Binding var showImagePickerSheet: Bool
    @Binding var addNewTextOptionsVM: AddNewTextOptionsViewModel
    @Binding var showAddNewTextOptionsView: Bool

    var body: some View {
        ZStack {
            ImagePicker(showImagePickerSheet: $showImagePickerSheet, addNewTextOptionsVM: $addNewTextOptionsVM, showAddNewTextOptionsView: $showAddNewTextOptionsView)
                .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    ImagePickerView(
        showImagePickerSheet: .constant(true),
        addNewTextOptionsVM: .constant(AddNewTextOptionsViewModel()),
        showAddNewTextOptionsView: .constant(true)
    )
}
