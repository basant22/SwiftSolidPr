//
//  PatientName.swift
//  SwiftSolidPr
//
//  Created by apple on 30/04/26.
//

import SwiftUI

struct PatientName: View {
    var patientDetail:PatientDetail
    var body: some View {
        VStack(alignment:.leading,spacing:8){
            Text(patientDetail.fullName)
                .font(.system(size: 24,weight:.semibold))
            
            Text("MRN:\(patientDetail.mrn)")
                .font(.caption)
                .foregroundColor(.gray)
            
            Text("Age:\(patientDetail.age) Sex:\(patientDetail.sex)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
        }
        .frame(maxWidth:.infinity,alignment:.leading)
        //.padding(.horizontal,15)
        //.background(Color.white,in: RoundedRectangle(cornerRadius: 12.0, style: .continuous))
    }
}

//struct PatientName_Previews: PreviewProvider {
//    static var previews: some View {
//        PatientName(patientDetail: <#T##PatientDetail#>)
//    }
//}
