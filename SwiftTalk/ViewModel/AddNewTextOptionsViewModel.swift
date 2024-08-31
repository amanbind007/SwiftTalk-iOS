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
    case doc
    case pdf

    var allowedContentType: [UTType] {
        switch self {
        case .text:
            return [.text, .plainText, .utf8PlainText]
        case .doc:
            return [UTType(importedAs: "com.amanbind.swifttalk.doc", conformingTo: .data)]
        case .pdf:
            return [.pdf]
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
        case .doc:
            self.convertDocToText(wordDocumentURL: documentURL)
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
    
    func convertDocToText(wordDocumentURL: URL) {
        var text = ""
        do {
            let data = try Data(contentsOf: wordDocumentURL)
            let file = try DocFile(data: data)
            
            if let characters = file.characters {
                // print(characters.text.trimmingCharacters(in: .whitespaces) as Any)
                text = characters.text.trimmingCharacters(in: .whitespaces)
                DispatchQueue.main.async {
                    let currentDate = Date()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yy HH.mm.ss"
                    let formattedDate = dateFormatter.string(from: currentDate)
                    let title = "DocText "+formattedDate
                    DataCoordinator.shared.saveObject(text: text.trimEndWhitespaceAndNewlines(), title: title, textSource: .wordDocument)
                }
            }
            
        } catch {
            self.showParseAlert = true
            self.errorMessage = error.localizedDescription
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
