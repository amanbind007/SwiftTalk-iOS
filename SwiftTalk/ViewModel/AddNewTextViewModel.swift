//
//  AddNewTextViewModel.swift
//  SwiftTalk
//
//  Created by Aman Bind on 08/04/24.
//

import Foundation
import OfficeFileReader
import PDFKit
import SwiftSoup
import SwiftUI
import UIKit
import Vision

@Observable
class AddNewTextViewModel {
    var isPlaying = false
    var isVoiceSelectorPresented = false
    var isVoiceSpeedSelectorPresented = false
    var degreesRotating = 0.0
    
    let pasteboard = UIPasteboard.general

    var title = ""
    var text = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce iaculis interdum ex. Donec faucibus orci purus, at sagittis lorem placerat at. Morbi sodales porta massa in blandit. Cras eget varius lacus. Cras ac libero quis velit semper dapibus. Maecenas viverra mauris nec maximus egestas. In hac habitasse platea dictumst. Quisque hendrerit scelerisque lorem sit amet pellentesque. Mauris luctus ipsum in pharetra finibus. Sed rutrum finibus dui. Mauris ullamcorper ut ante vel congue. Nullam ac justo sagittis, tincidunt velit id, consequat velit. Vivamus purus turpis, condimentum eu blandit nec, ullamcorper et erat. Fusce velit eros, ornare at lectus quis, interdum varius urna.
    """
    
    // Web Link Text Sheet View Properties
    var link: String = ""
    var isParsingWebText: Bool = false
    
    // Image Text Sheet View Properties
    var selectedImages: [UIImage] = []
    var isProcessingImages: Bool = false
    
    // File Export Sheet View Properties
    
    func getTextFromLink() {
        isParsingWebText = true
        
        if let url = URL(string: link) {
            URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                if let error = error {
                    print(error.localizedDescription)
                    self.isParsingWebText = false
                } else {
                    if let data = data {
                        let html = String(data: data, encoding: .utf8)!
                        
                        do {
                            let doc: Document = try SwiftSoup.parse(html)
                            guard let body = doc.body() else { return }
                            let text = try body.text()
                            
                            self.text = text
                            
                            self.isParsingWebText = false
                            
                        } catch {
                            print(error)
                            self.isParsingWebText = false
                        }
                    }
                }
            }.resume()
        } else {
            isParsingWebText = false
        }
    }
    
    func convertPDFToText(yourDocumentURL: URL) {
        if let pdf = PDFDocument(url: yourDocumentURL) {
            let pageCount = pdf.pageCount
            let documentContent = NSMutableAttributedString()

            for i in 0 ..< pageCount {
                guard let page = pdf.page(at: i) else { continue }
                guard let pageContent = page.attributedString else { continue }
                documentContent.append(pageContent)
            }
            
            print(documentContent.string)
        }
    }
    
    func convertDocToText(yourDocumentURL: URL) {
        do {
            let data = try Data(contentsOf: yourDocumentURL)
            let file = try DocFile(data: data)
            
            if let characters = file.characters {
                print(characters.text.trimmingCharacters(in: .whitespaces) as Any)
            }
            
        } catch {
            print(error)
        }
    }
    
    func getTextFromTextFile(textFile: URL) {
        do {
            let text = try String(contentsOf: textFile)
            print(text)
        } catch {
            print(error)
        }
    }
    
    func getTextFromImages() {
        // let image = UIImage(named: "quote")
        
        text = ""
        isProcessingImages = true
        
        for image in selectedImages {
            if let cgImage = image.cgImage {
                // Request handler
                let handler = VNImageRequestHandler(cgImage: cgImage)
                    
                let recognizeRequest = VNRecognizeTextRequest { request, _ in
                        
                    // Parse the results as text
                    guard let result = request.results as? [VNRecognizedTextObservation] else {
                        return
                    }
                        
                    // Extract the data
                    let stringArray = result.compactMap { result in
                        result.topCandidates(1).first?.string
                    }
                        
                    // Update the UI
                    DispatchQueue.main.async {
                        self.text.append(stringArray.joined(separator: "\n"))
                    }
                }
                    
                // Process the request
                recognizeRequest.recognitionLevel = .accurate
                recognizeRequest.automaticallyDetectsLanguage = true
                
                do {
                    try handler.perform([recognizeRequest])
                } catch {
                    print(error)
                }
                print(text)
                
                isProcessingImages = false
            }
        }
    }
}
