//
//  UISliderView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 10/04/24.
//

import SwiftUI

import SwiftUI

struct LinearGradientSlider: View {
    @Binding var value: Double
    var colors: [Color] = [.pink, .purple]
    var range: ClosedRange<Double>
    var step: Double
    var onEditingChanged: (Bool) -> Void
    
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: colors),
                startPoint: .leading,
                endPoint: .trailing
            )
            .mask(Slider(value: $value, in: range, step: step))
            

            
            Slider(value: $value, in: range, onEditingChanged: onEditingChanged)
                .tint(.clear)
            
        }
        .frame(height: .leastNormalMagnitude)
    }
}

#Preview {
    LinearGradientSlider(value: .constant(5), range: 0.0...10.0, step: 1.0) { _ in
        // Action
    }
}
