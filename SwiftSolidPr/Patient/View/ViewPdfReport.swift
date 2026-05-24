//
//  ViewPdfReport.swift
//  SwiftSolidPr
//
//  Created by apple on 12/05/26.
//

import SwiftUI

struct ViewPdfReport: View {
    let pData:[PatientData] 
    var body: some View {
        List(pData) { data in
            PDFKitView(pdfData: data.file)
                .frame(maxWidth:.infinity,minHeight: 300) // PDF needs a height to be visible in a list
        }
        .navigationTitle("Patient Report")
    }
}

struct ViewPdfReport_Previews: PreviewProvider {
    static var previews: some View {
        ViewPdfReport(pData: [PatientData(patientId: 0, file: Data())])
    }
}
