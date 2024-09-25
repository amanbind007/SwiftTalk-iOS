//
//  AddNewTextOptionsViewModel.swift
//  SwiftTalk
//
//  Created by Aman Bind on 03/07/24.
//

import Foundation
import OfficeFileReader
import PDFKit
import SwiftData
import SwiftSoup
import SwiftUI
import UIKit
import UniformTypeIdentifiers
import Vision

enum FileImportTypes {
    case text
    case pdf

    var allowedContentType: [UTType] {
        switch self {
        case .text:
            return [.text, .plainText, .utf8PlainText]
        case .pdf:
            return [.pdf]
        }
    }
}

enum TextSource: String, CaseIterable, Identifiable, Codable {
//    case camera = "Camera Scan"
    case photoLibrary = "Photo Library"
    case textInput = "Text"
    case pdfDocument = "PDF Documents"
    case webpage = "Webpage"
    case textFile = "Text Document"

    var id: String { self.rawValue }

    var title: String { self.rawValue }
    var description: String {
        switch self {
//        case .camera: return "Scan physical text using your camera"
        case .photoLibrary: return "Get text from the photos in your library"
        case .textInput: return "Input or paste text to read"
        case .pdfDocument: return "Add PDFs from your local storage or cloud"
        case .webpage: return "Listen to the contents of a webpage"
        case .textFile: return "Add text documents from your local storage or cloud"
        }
    }

    var imageName: String {
        switch self {
//        case .camera: return Constants.Icons.cameraIcon
        case .photoLibrary: return Constants.Icons.imageFileIcon
        case .textInput: return Constants.Icons.textFileInputIcon
        case .pdfDocument: return Constants.Icons.pdfFileIcon
        case .webpage: return Constants.Icons.webIcon
        case .textFile: return Constants.Icons.textFileIcon
        }
    }

    var color: Color {
        switch self {
//        case .camera: return Color.pink
        case .photoLibrary: return Color.green
        case .textInput: return Color.purple
        case .pdfDocument: return Color.red
        case .webpage: return Color.mint
        case .textFile: return Color.secondary
        }
    }
}

@Observable
class AddNewTextOptionsViewModel {
    var pasteboard = UIPasteboard.general
    
    var showWebTextSheet: Bool = false
    var showImagePickerSheet: Bool = false
    var showFileImporterSheet: Bool = false
    var fileType: FileImportTypes?
    
    // Web Link Text Sheet View Properties
    var link: String = ""
    var isParsingWebText: Bool = false
    
    // Text Parsing Alert properties
    var showParseAlert: Bool = false
    var errorMessage: String?

    // Image Text Sheet View Properties
    var selectedImages: [UIImage] = []
    var isProcessingImages: Bool = false
    var progressValue: Double = 0
    
    func getTextFromLink(completion: @escaping (Bool) -> Void) {
        var text = ""
        
        if let url = URL(string: link) {
            self.errorMessage = nil
            self.isParsingWebText = true
            let session = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                if let error = error {
                    // print(error.localizedDescription)
                    self.errorMessage = error.localizedDescription
                    self.isParsingWebText = false
                    completion(false)
                } else {
                    if let data = data {
                        let html = String(data: data, encoding: .utf8)!
                        
                        do {
                            let doc: Document = try SwiftSoup.parse(html)
                            guard let body = doc.body() else {
                                completion(false)
                                return
                            }
                            text = try body.text()
                            
                            DispatchQueue.main.async {
                                let currentDate = Date()
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "dd-MM-yy HH.mm.ss"
                                let formattedDate = dateFormatter.string(from: currentDate)
                                let title = "WebText "+formattedDate
                                if text != "" {
                                    DataCoordinator.shared.saveObject(text: text.trimEndWhitespaceAndNewlines(), title: title, textSource: .webpage)
                                    completion(true)
                                } else {
                                    print("Text: \(text)")
                                    self.errorMessage = "Failed to retrieve text."
                                }
                                self.isParsingWebText = false
                            }
                            
                        } catch {
                            print(error.localizedDescription)
                            self.errorMessage = error.localizedDescription
                            self.isParsingWebText = false
                            completion(false)
                        }
                    } else {
                        completion(false)
                    }
                }
            }
            
            session.resume()
        } else {
            completion(false)
        }
    }

    func convertFileToText(documentURL: URL) {
        switch self.fileType {
        case .pdf:
            self.convertPDFToText(pdfDocumentURL: documentURL)
        case .text:
            self.getTextFromTextFile(textFileURL: documentURL)
        case .none:
            return
        }
    }
    
    func convertPDFToText(pdfDocumentURL: URL) {
        var text = ""
        if let pdf = PDFDocument(url: pdfDocumentURL) {
            let pageCount = pdf.pageCount
            let documentContent = NSMutableAttributedString()

            for i in 0 ..< pageCount {
                guard let page = pdf.page(at: i) else { continue }
                guard let pageContent = page.attributedString else { continue }
                documentContent.append(pageContent)
            }
            
            text = documentContent.string
            DispatchQueue.main.async {
                let currentDate = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yy HH.mm.ss"
                let formattedDate = dateFormatter.string(from: currentDate)
                let title = "PDFText "+formattedDate
                DataCoordinator.shared.saveObject(text: text.trimEndWhitespaceAndNewlines(), title: title, textSource: .pdfDocument)
            }
        } else {
            self.showParseAlert = true
            self.errorMessage = "Couldn't parse the PDF"
        }
    }
    
    func getTextFromTextFile(textFileURL: URL) {
        do {
            let text = try String(contentsOf: textFileURL)
            DispatchQueue.main.async {
                let currentDate = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yy HH.mm.ss"
                let formattedDate = dateFormatter.string(from: currentDate)
                let title = "Text "+formattedDate

                DataCoordinator.shared.saveObject(text: text.trimEndWhitespaceAndNewlines(), title: title, textSource: .textFile)
            }
        } catch {
            self.showParseAlert = true
            self.errorMessage = error.localizedDescription
        }
    }
    
    func getTextFromImages(progress: @escaping (Double) -> Void) {
        var text = ""
        self.isProcessingImages = true
        let totalImages = self.selectedImages.count
        self.progressValue = 0.0
        
        for (index, image) in self.selectedImages.enumerated() {
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
                        
                    // append parsed text
                    DispatchQueue.main.async {
                        text.append(stringArray.joined(separator: "\n"))
                    }
                }
                    
                // Process the request
                recognizeRequest.recognitionLevel = .accurate
                recognizeRequest.automaticallyDetectsLanguage = true
                recognizeRequest.progressHandler = { _, value, _ in
                    
                    // show progress bar or something
                }
                
                do {
                    try handler.perform([recognizeRequest])
                    
                } catch {
                    self.isProcessingImages = false
                    self.errorMessage = error.localizedDescription
                    self.showParseAlert = true
                    print(error)
                }
            }
        }
        
        self.isProcessingImages = false
        
        DispatchQueue.main.async {
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yy HH.mm.ss"
            let formattedDate = dateFormatter.string(from: currentDate)
            let title = "ImgText "+formattedDate
            
            if text != "" {
                DataCoordinator.shared.saveObject(text: text.trimEndWhitespaceAndNewlines(), title: title, textSource: .photoLibrary)
            } else {
                self.errorMessage = "Couldn't parse any text from photo(s)"
                self.showParseAlert = true
            }
        }
    }
}
