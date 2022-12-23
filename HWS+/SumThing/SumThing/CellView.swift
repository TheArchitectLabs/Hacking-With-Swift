//
//  CellView.swift
//  SumThing
//
//  Created by Michael & Diana Pascucci on 12/23/22.
//

import SwiftUI

struct CellView: View {
    
    // MARK: - PROPERTIES
    let number: Int
    let isSelected: Bool
    var onSelected: () -> Void
    
    var displayNumber: String {
        if number == 0 {
            return ""
        } else {
            return String(number)
        }
    }
    
    // MARK: - BODY
    var body: some View {
        Button(action: onSelected) {
            Text(displayNumber)
                .font(.largeTitle)
                .monospacedDigit()
                .frame(maxWidth: 100, maxHeight: 100)
                .aspectRatio(1, contentMode: .fit)
                .foregroundColor(isSelected ? .white : .primary)
                .background(isSelected ? .blue : .clear)
                .border(.primary.opacity(0.3), width: 1)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - PREVIEW
struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(number: 8, isSelected: true) { }
    }
}
