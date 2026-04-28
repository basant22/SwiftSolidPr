//
//  PatintView.swift
//  SwiftSolidPr
//
//  Created by apple on 27/04/26.
//

import SwiftUI
struct PatientRowView: View {
    let patient: PatientRecord
    
    var body: some View {
        NavigationLink(destination: Text("Details for \(patient.fullName)")) {
            VStack(alignment: .leading, spacing: 4) {
                Text(patient.fullName)
                    .fontWeight(.medium)
                
                Text("\(patient.wardNumber) • \(patient.bed)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(patient.doctorName)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading) // Set alignment to leading
            .background(
                RoundedRectangle(cornerRadius: 12.0, style: .continuous)
                    .fill(Color.cyan.opacity(0.15)) // Using opacity makes it look more modern
            )
        }
        .buttonStyle(.plain)
        .padding(.horizontal)
    }
}
