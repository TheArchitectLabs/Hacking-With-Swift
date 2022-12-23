//
//  SumView.swift
//  SumThing
//
//  Created by Michael & Diana Pascucci on 12/23/22.
//

import SwiftUI

struct SumView: View {
    
    // MARK: - PROPERTIES
    @ScaledMetric(relativeTo: .title) var frameWidth = 50
    var number: Int
    
    // MARK: - BODY
    var body: some View {
        Text(String(number))
            .font(.title)
            .monospacedDigit()
            .frame(width: frameWidth, height: frameWidth)
    }
}

// MARK: - PREVIEW
struct SumView_Previews: PreviewProvider {
    static var previews: some View {
        SumView(number: 9)
    }
}
