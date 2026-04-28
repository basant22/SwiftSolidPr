//
//  TabButton.swift
//  SwiftSolidPr
//
//  Created by apple on 01/04/26.
//

import SwiftUI

struct TabButton: View {
    let index: Int
    let icon: String
    let label: String
    @Binding var selected: Int
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                selected = index
            }
        }) {
            VStack(spacing: 4) {
                Image(systemName: selected == index ? "\(icon).fill" : icon)
                    .font(.system(size: 22))
                
                Text(label)
                    .font(.caption2)
                    .fontWeight(selected == index ? .bold : .regular)
            }
            .foregroundColor(selected == index ? .borderColor : .gray)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
        }
    }
}
