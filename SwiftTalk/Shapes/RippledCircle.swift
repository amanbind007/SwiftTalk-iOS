//
//  RippledCircle.swift
//  SwiftTalk
//
//  Created by Aman Bind on 14/03/24.
//

import SwiftUI

struct RippledCircle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.4684*width, y: 0.02578*height))
        path.addLine(to: CGPoint(x: 0.57127*width, y: 0.05813*height))
        path.addLine(to: CGPoint(x: 0.6652*width, y: 0.05432*height))
        path.addLine(to: CGPoint(x: 0.74615*width, y: 0.12607*height))
        path.addLine(to: CGPoint(x: 0.83359*width, y: 0.16092*height))
        path.addLine(to: CGPoint(x: 0.87836*width, y: 0.25969*height))
        path.addLine(to: CGPoint(x: 0.94432*width, y: 0.32726*height))
        path.addLine(to: CGPoint(x: 0.94507*width, y: 0.43573*height))
        path.addLine(to: CGPoint(x: 0.97809*width, y: 0.52449*height))
        path.addLine(to: CGPoint(x: 0.93488*width, y: 0.62374*height))
        path.addLine(to: CGPoint(x: 0.92907*width, y: 0.71834*height))
        path.addLine(to: CGPoint(x: 0.8496*width, y: 0.79132*height))
        path.addLine(to: CGPoint(x: 0.80594*width, y: 0.87523*height))
        path.addLine(to: CGPoint(x: 0.7039*width, y: 0.9096*height))
        path.addLine(to: CGPoint(x: 0.63007*width, y: 0.96823*height))
        path.addLine(to: CGPoint(x: 0.52283*width, y: 0.95806*height))
        path.addLine(to: CGPoint(x: 0.43173*width, y: 0.98138*height))
        path.addLine(to: CGPoint(x: 0.33774*width, y: 0.92819*height))
        path.addLine(to: CGPoint(x: 0.24505*width, y: 0.91233*height))
        path.addLine(to: CGPoint(x: 0.18075*width, y: 0.82514*height))
        path.addLine(to: CGPoint(x: 0.10234*width, y: 0.77282*height))
        path.addLine(to: CGPoint(x: 0.07908*width, y: 0.66684*height))
        path.addLine(to: CGPoint(x: 0.02847*width, y: 0.58694*height))
        path.addLine(to: CGPoint(x: 0.05021*width, y: 0.48076*height))
        path.addLine(to: CGPoint(x: 0.03628*width, y: 0.38701*height))
        path.addLine(to: CGPoint(x: 0.099*width, y: 0.29901*height))
        path.addLine(to: CGPoint(x: 0.1243*width, y: 0.20774*height))
        path.addLine(to: CGPoint(x: 0.21706*width, y: 0.15289*height))
        path.addLine(to: CGPoint(x: 0.27714*width, y: 0.08002*height))
        path.addLine(to: CGPoint(x: 0.38408*width, y: 0.06764*height))
        path.addLine(to: CGPoint(x: 0.4684*width, y: 0.02577*height))
        path.closeSubpath()
        return path
    }
}
