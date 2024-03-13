//
//  FlowerCloud.swift
//  SwiftTalk
//
//  Created by Aman Bind on 13/03/24.
//

import Foundation
import SwiftUI

struct FlowerCloud: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.88889*width, y: 0.33333*height))
        path.addCurve(to: CGPoint(x: 0.65*width, y: 0.11481*height), control1: CGPoint(x: 0.92407*width, y: 0.17593*height), control2: CGPoint(x: 0.81111*width, y: 0.07037*height))
        path.addCurve(to: CGPoint(x: 0.32593*width, y: 0.11111*height), control1: CGPoint(x: 0.56111*width, y: -0.02778*height), control2: CGPoint(x: 0.40926*width, y: -0.02778*height))
        path.addCurve(to: CGPoint(x: 0.10741*width, y: 0.34815*height), control1: CGPoint(x: 0.16852*width, y: 0.07778*height), control2: CGPoint(x: 0.06481*width, y: 0.18889*height))
        path.addCurve(to: CGPoint(x: 0.1037*width, y: 0.67037*height), control1: CGPoint(x: -0.03333*width, y: 0.43519*height), control2: CGPoint(x: -0.03333*width, y: 0.58704*height))
        path.addCurve(to: CGPoint(x: 0.34259*width, y: 0.88889*height), control1: CGPoint(x: 0.06852*width, y: 0.82778*height), control2: CGPoint(x: 0.18148*width, y: 0.93333*height))
        path.addCurve(to: CGPoint(x: 0.66667*width, y: 0.89259*height), control1: CGPoint(x: 0.43148*width, y: 1.03148*height), control2: CGPoint(x: 0.58333*width, y: 1.03148*height))
        path.addCurve(to: CGPoint(x: 0.88519*width, y: 0.65556*height), control1: CGPoint(x: 0.82407*width, y: 0.92593*height), control2: CGPoint(x: 0.92778*width, y: 0.81481*height))
        path.addCurve(to: CGPoint(x: 0.88889*width, y: 0.33333*height), control1: CGPoint(x: 1.02593*width, y: 0.56852*height), control2: CGPoint(x: 1.02407*width, y: 0.41667*height))
        path.closeSubpath()
        return path
    }
}
