//
//  ImageCropperView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 21/10/24.
//

import SwiftUI
import WeScan

struct ImageCropperView: UIViewControllerRepresentable {

    typealias UIViewControllerType = ImageScannerController

    let image: UIImage
    let onCrop: (UIImage) -> Void
    
    class Coordinator: NSObject, ImageScannerControllerDelegate {
        func imageScannerController(_ scanner: WeScan.ImageScannerController, didFinishScanningWithResults results: WeScan.ImageScannerResults) {
            //get the quad and send to editScannedImageController(?)
        }
        
        func imageScannerControllerDidCancel(_ scanner: WeScan.ImageScannerController) {
            //close the view
        }
        
        func imageScannerController(_ scanner: WeScan.ImageScannerController, didFailWithError error: any Error) {
            //close the view
        }
        
            let parent: ImageCropperView
            
            init(_ parent: ImageCropperView) {
                self.parent = parent
            }
        }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> WeScan.ImageScannerController {
        let vc = ImageScannerController(image: image)

        return vc
    }

    func updateUIViewController(_ uiViewController: WeScan.ImageScannerController, context: Context) {

    }

}



#Preview {
    ImageSorterView()
}