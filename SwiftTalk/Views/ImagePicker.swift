//
//  imagePickerView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 18/04/24.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var showImagePickerSheet: Bool
    @Binding var addNewTextOptionsVM: AddNewTextOptionsViewModel

    @Binding var showAddNewTextOptionsView: Bool

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator

        return picker
    }

    func updateUIViewController(_ picker: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}

class Coordinator: NSObject, PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let imageItems = results
            .map { $0.itemProvider }
            .filter { $0.canLoadObject(ofClass: UIImage.self) } // filter for possible UIImages

        if imageItems.isEmpty {
            self.parent.showImagePickerSheet = false
            return
        }

        let dispatchGroup = DispatchGroup()

        for imageItem in imageItems {
            dispatchGroup.enter() // signal IN

            imageItem.loadObject(ofClass: UIImage.self) { image, _ in
                if let image = image as? UIImage {
                    self.parent.addNewTextOptionsVM.selectedImages.append(image)
                }
                dispatchGroup.leave() // signal OUT
            }
        }
        self.parent.showImagePickerSheet = false
        self.parent.showAddNewTextOptionsView = false

        // This is called at the end; after all signals are matched (IN/OUT)
        dispatchGroup.notify(queue: .main) {
            self.parent.addNewTextOptionsVM.getTextFromImages()
        }
    }

    let parent: ImagePicker

    init(parent: ImagePicker) {
        self.parent = parent
    }
}

#Preview {
    ImagePickerView(showImagePickerSheet: .constant(true), addNewTextOptionsVM: .constant(AddNewTextOptionsViewModel()), showAddNewTextOptionsView: .constant(false))
}
