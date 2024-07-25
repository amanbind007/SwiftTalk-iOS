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

@Observable
class AddNewTextOptionsViewModel {
    var pasteboard = UIPasteboard.general
    
    // Web Link Text Sheet View Properties
    var link: String = ""
    var isParsingWebText: Bool = false
    var errorMessage: String?

    // Image Text Sheet View Properties
    var selectedImages: [UIImage] = []
    var isProcessingImages: Bool = false
    
    func getTextFromLink(completion: @escaping (Bool) -> Void) {
        var text = ""
        self.isParsingWebText = true

        if let url = URL(string: link) {
            let session = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                if let error = error {
                    print(error.localizedDescription)
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
                                self.errorMessage = nil
                                let currentDate = Date()
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd HH.mm.ss"
                                let formattedDate = dateFormatter.string(from: currentDate)
                                let title = "WebText "+formattedDate
                                DataCoordinator.shared.saveObject(text: text.trimEndWhitespaceAndNewlines(), title: title, textSource: .webpage)
                                self.isParsingWebText = false
                                completion(text != "")
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

    func convertFileToText(fileType: FileImportTypes, documentURL: URL) {
        switch fileType {
        case .pdf:
            self.convertPDFToText(pdfDocumentURL: documentURL)
        case .doc:
            self.convertDocToText(wordDocumentURL: documentURL)
        case .text:
            self.getTextFromTextFile(textFileURL: documentURL)
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
                dateFormatter.dateFormat = "yyyy-MM-dd HH.mm.ss"
                let formattedDate = dateFormatter.string(from: currentDate)
                let title = "PDFText "+formattedDate
                DataCoordinator.shared.saveObject(text: text.trimEndWhitespaceAndNewlines(), title: title, textSource: .pdfDocument)
            }
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
                    dateFormatter.dateFormat = "yyyy-MM-dd HH.mm.ss"
                    let formattedDate = dateFormatter.string(from: currentDate)
                    let title = "DocText "+formattedDate
                    DataCoordinator.shared.saveObject(text: text.trimEndWhitespaceAndNewlines(), title: title, textSource: .wordDocument)
                }
            }
            
        } catch {
            print(error)
        }
    }
    
    func getTextFromTextFile(textFileURL: URL) {
        do {
            let text = try String(contentsOf: textFileURL)
            print(text)
            DispatchQueue.main.async {
                let currentDate = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH.mm.ss"
                let formattedDate = dateFormatter.string(from: currentDate)
                let title = "Text "+formattedDate

                DataCoordinator.shared.saveObject(text: text.trimEndWhitespaceAndNewlines(), title: title, textSource: .textFile)
            }
        } catch {
            print(error)
        }
    }
    
    func getTextFromImages() {
        // let image = UIImage(named: "quote")
        
        var text = ""
        self.isProcessingImages = true
        
        for image in self.selectedImages {
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
                        text.append(stringArray.joined(separator: "\n"))
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
                // print(text)
                
                self.isProcessingImages = false
            }
        }
        
        DispatchQueue.main.async {
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH.mm.ss"
            let formattedDate = dateFormatter.string(from: currentDate)
            let title = "ImageText "+formattedDate
            DataCoordinator.shared.saveObject(text: text.trimEndWhitespaceAndNewlines(), title: title, textSource: .photoLibrary)
        }
    }
}
