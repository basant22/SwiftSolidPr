//
//  PdfView.swift
//  SwiftSolidPr
//
//  Created by apple on 12/05/26.
//


import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    let pdfData: Data

    func makeUIView(context: Context) -> PDFView {
        //        let pdfView = PDFView()
        //        pdfView.document = PDFDocument(url: url)
        //        pdfView.autoScales = true
        //        return pdfView
        let pdfView = PDFView()
        // 1. Basic Scaling
        pdfView.autoScales = true
        
        // 2. Set the zoom limits (Senior Tip: Default is often too restrictive)
        pdfView.minScaleFactor = 0.1  // How small it can go
        pdfView.maxScaleFactor = 5.0  // How large it can go (500% zoom)
        
        // 3. Optional: Allow the user to "flick" to zoom
        pdfView.displaysPageBreaks = true
        pdfView.document = PDFDocument(data: pdfData)
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}

// Usage in SwiftUI
//struct ReportView: View {
//    var body: some View {
//        if let url = getFileURL(for: "shipment_402.pdf") {
//            PDFKitView(url: url)
//                .navigationTitle("Shipment PDF")
//        } else {
//            Text("File not found")
//        }
//    }
//}
