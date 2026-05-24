//
//  PatintView.swift
//  SwiftSolidPr
//
//  Created by apple on 27/04/26.
//

import SwiftUI
struct PatientRowView: View {
    @Binding var patient: PatientRecord
    var viewModal:PatientViewModal
   // @Binding var isFavorite:Bool
    var body: some View {
       // PDetail(viewModal: viewModal,patientId: patient.id)
        //PatientDetailView(patientId: patient.id, viewModal: viewModal)
        NavigationLink(destination: PatientDetailView(patientId: patient.id, viewModal: viewModal)) {
            VStack(alignment: .leading, spacing: 4) {
                Text(patient.fullName)
                    .fontWeight(.medium)
                
                Text("\(patient.wardNumber) • \(patient.bed)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(patient.doctorName)
                    .font(.caption)
                    .foregroundColor(.secondary)
                HStack{
                    Spacer()
                    Toggle("Favorite", isOn: $patient.isFavorite)
                        .toggleStyle(.switch)
                        .tint(.green)
                }
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
