////
////  PDFView.swift
////  SwiftTalk
////
////  Created by Aman Bind on 31/05/25.
////
//
//import PDFKit
//import SwiftUI
//
//struct PDFViewer: UIViewRepresentable {
//    
//    let pdfDocument: PDFDocument
//    @Binding var currentPage: Int?
//    @Binding var highlightedRange: NSRange?
//    
//    var onCharacterTapped: ((_ page: Int, _ index: Int) -> Void)?
//    
//    @AppStorage("autoScroll") var autoScroll = true
//    @AppStorage("backgroundColor") var backgroundColor: Color = Color(UIColor(red: 1.00, green: 0.97, blue: 0.42, alpha: 1.00))
//    @AppStorage("foregroundColor") var foregroundColor: Color = Color(UIColor(red: 0.83, green: 0.00, blue: 0.00, alpha: 1.00))
//    
//    func makeUIView(context: Context) -> PDFView {
//        let pdfView = PDFView()
//        pdfView.document = pdfDocument
//        pdfView.autoScales = true
//        pdfView.displayMode = .singlePage
//        pdfView.displayDirection = .vertical
//        pdfView.usePageViewController(true)
//        pdfView.delegate = context.coordinator
//        
//        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(_:)))
//        pdfView.addGestureRecognizer(tapGesture)
//                
//        
//        return pdfView
//    }
//    
//    func updateUIView(_ pdfView: PDFView, context: Context) {
//        pdfView.document = pdfDocument
//        if let page = pdfDocument.page(at: currentPage!) {
//            //pdfView.go(to: page)
//            
//            // Update highlighting
//            if let range = highlightedRange {
//                pdfView.setCurrentSelection(pdfView.document?.selection(from: page, atCharacterIndex: range.upperBound, to: page, atCharacterIndex: range.lowerBound), animate: true)
//
//                if let pageContent = page.string {
//                    //let nsString = pageContent as NSString
////                    let word = nsString.substring(with: range)
//                    
//                    if let selection = pdfView.document?.selection(from: page, atCharacterIndex: range.location, to: page, atCharacterIndex: range.upperBound) {
//                        pdfView.setCurrentSelection(selection, animate: true)
//                        print(selection.bounds(for: page))
//                    }
//                }
//            } else {
//                pdfView.clearSelection()
//            }
//        }
//        
//    }
//    
//    func makeCoordinator() -> PDFViewCoordinator {
//        PDFViewCoordinator(self)
//    }
//    
//}
//
//class PDFViewCoordinator: NSObject, PDFViewDelegate {
//    var parent: PDFViewer
//    
//    init(_ parent: PDFViewer) {
//        self.parent = parent
//    }
//    
//    func pdfViewPageChanged(_ notification: Notification) {
//        guard let pdfView = notification.object as? PDFView,
//              let currentPage = pdfView.currentPage,
//              let pageIndex = pdfView.document?.index(for: currentPage) else { return }
//        parent.currentPage = pageIndex
//    }
//    
//    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
//                guard let pdfView = gesture.view as? PDFView, let currentPage = pdfView.currentPage else { return }
//                
//                let tapLocation = gesture.location(in: pdfView)
//                let pagePoint = pdfView.convert(tapLocation, to: currentPage)
//                let pageIndex = pdfView.document?.index(for: currentPage) ?? 0
//                
//                // Try to get character index at tapped location
//                if let selection = currentPage.selection(for: CGRect(origin: pagePoint, size: CGSize(width: 2, height: 2))),
//                   !selection.string!.isEmpty,
//                   let pageText = currentPage.string,
//                   let range = pageText.range(of: selection.string!) {
//                    
//                    let characterIndex = pageText.distance(from: pageText.startIndex, to: range.lowerBound)
//                    
//                    DispatchQueue.main.async {
//                        self.parent.currentPage = pageIndex
//                        print(characterIndex)
//                        self.parent.onCharacterTapped?(pageIndex, characterIndex)
//                    }
//                }
//            }
//}
//
//
//
//
//#Preview(body: {
//    PDFViewer(pdfDocument: PDFDocument(url: Bundle.main.url(forResource: "Rye", withExtension: "pdf")!)!, currentPage: .constant(1), highlightedRange: .constant(nil))
//})

import PDFKit
import SwiftUI

struct PDFViewer: UIViewRepresentable {
    
    let pdfDocument: PDFDocument
    @Binding var currentPage: Int?
    @Binding var highlightedRange: NSRange?
    
    var onCharacterTapped: ((_ page: Int, _ index: Int) -> Void)?
    
    @AppStorage("autoScroll") var autoScroll = true
    @AppStorage("backgroundColor") var backgroundColor: Color = Color(UIColor(red: 1.00, green: 0.97, blue: 0.42, alpha: 1.00))
    @AppStorage("foregroundColor") var foregroundColor: Color = Color(UIColor(red: 0.83, green: 0.00, blue: 0.00, alpha: 1.00))
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        pdfView.displayMode = .singlePage
        pdfView.displayDirection = .vertical
        pdfView.usePageViewController(true)
        pdfView.delegate = context.coordinator
        
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(_:)))
        pdfView.addGestureRecognizer(tapGesture)
        
        return pdfView
    }
    
    func updateUIView(_ pdfView: PDFView, context: Context) {
        pdfView.document = pdfDocument
        if let page = pdfDocument.page(at: currentPage!) {
            
            // Update highlighting
            if let range = highlightedRange {
                pdfView.setCurrentSelection(pdfView.document?.selection(from: page, atCharacterIndex: range.upperBound, to: page, atCharacterIndex: range.lowerBound), animate: true)

                if let pageContent = page.string {
                    if let selection = pdfView.document?.selection(from: page, atCharacterIndex: range.location, to: page, atCharacterIndex: range.upperBound) {
                        pdfView.setCurrentSelection(selection, animate: true)
                        //print(selection.bounds(for: page))
                    }
                }
            } else {
                pdfView.clearSelection()
            }
        }
    }
    
    func makeCoordinator() -> PDFViewCoordinator {
        PDFViewCoordinator(self)
    }
}

class PDFViewCoordinator: NSObject, PDFViewDelegate {
    var parent: PDFViewer
    
    init(_ parent: PDFViewer) {
        self.parent = parent
    }
    
    func pdfViewPageChanged(_ notification: Notification) {
        guard let pdfView = notification.object as? PDFView,
              let currentPage = pdfView.currentPage,
              let pageIndex = pdfView.document?.index(for: currentPage) else { return }
        parent.currentPage = pageIndex
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        
        guard let pdfView = gesture.view as? PDFView else {
            return
        }
        
        guard let currentPage = pdfView.currentPage else {
            return
        }
        
        let tapLocation = gesture.location(in: pdfView)
        let pagePoint = pdfView.convert(tapLocation, to: currentPage)
        let pageIndex = pdfView.document?.index(for: currentPage) ?? 0
        
        // Try different selection sizes to catch text
        let selectionSizes = [
            CGSize(width: 5, height: 5),
            CGSize(width: 10, height: 10),
            CGSize(width: 20, height: 20)
        ]
        
        for size in selectionSizes {
            let selectionRect = CGRect(
                origin: CGPoint(x: pagePoint.x - size.width/2, y: pagePoint.y - size.height/2),
                size: size
            )
            
            if let selection = currentPage.selection(for: selectionRect) {
                let selectedText = selection.string ?? ""
                
                if !selectedText.isEmpty {
                    if let pageText = currentPage.string,
                       let range = pageText.range(of: selectedText) {
                        
                        let characterIndex = pageText.distance(from: pageText.startIndex, to: range.lowerBound)
                        
                        DispatchQueue.main.async {
                            self.parent.currentPage = pageIndex
                            self.parent.onCharacterTapped?(pageIndex, characterIndex)
                        }
                        return // Exit once we find text
                    }
                }
            }
        }
    }
}

#Preview(body: {
    PDFViewer(
        pdfDocument: PDFDocument(url: Bundle.main.url(forResource: "Rye", withExtension: "pdf")!)!,
        currentPage: .constant(1),
        highlightedRange: .constant(nil)
    )
})
