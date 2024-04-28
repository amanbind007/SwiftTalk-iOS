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
    @Bindable var addNewTextVM: AddNewTextViewModel

    @Binding var viewModel: NavigationStateViewModel

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // No update needed for PHPickerViewController
    }

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
                    self.parent.addNewTextVM.selectedImages.append(image)
                }
                dispatchGroup.leave() // signal OUT
            }
        }
        self.parent.showImagePickerSheet = false
        self.parent.viewModel.showAddNewTextOptionsView = false
        self.parent.viewModel.targetDestination.append(.textInput)

        // This is called at the end; after all signals are matched (IN/OUT)
        dispatchGroup.notify(queue: .main) {
            self.parent.addNewTextVM.getTextFromImages()
        }
    }

    let parent: ImagePicker

    init(parent: ImagePicker) {
        self.parent = parent
    }
}

// #Preview{
//    ImagePickerView(selectedImages: .constant())
// }
