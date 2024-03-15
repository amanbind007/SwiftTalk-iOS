//
//  HexagonShape.swift
//  SwiftTalk
//
//  Created by Aman Bind on 14/03/24.
//

import Foundation
import SwiftUI

struct HexagonShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.23712*height))
        path.addCurve(to: CGPoint(x: 0.07885*width, y: 0.14075*height), control1: CGPoint(x: 0, y: 0.19012*height), control2: CGPoint(x: 0.03268*width, y: 0.14953*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.09*height), control1: CGPoint(x: 0.18241*width, y: 0.12104*height), control2: CGPoint(x: 0.36671*width, y: 0.09*height))
        path.addCurve(to: CGPoint(x: 0.92115*width, y: 0.14075*height), control1: CGPoint(x: 0.63329*width, y: 0.09*height), control2: CGPoint(x: 0.81759*width, y: 0.12104*height))
        path.addCurve(to: CGPoint(x: width, y: 0.23712*height), control1: CGPoint(x: 0.96732*width, y: 0.14953*height), control2: CGPoint(x: width, y: 0.19012*height))
        path.addLine(to: CGPoint(x: width, y: 0.75187*height))
        path.addCurve(to: CGPoint(x: 0.9256*width, y: 0.84698*height), control1: CGPoint(x: width, y: 0.79712*height), control2: CGPoint(x: 0.96966*width, y: 0.83666*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.90967*height), control1: CGPoint(x: 0.82342*width, y: 0.8709*height), control2: CGPoint(x: 0.63676*width, y: 0.90967*height))
        path.addCurve(to: CGPoint(x: 0.0744*width, y: 0.84698*height), control1: CGPoint(x: 0.36325*width, y: 0.90967*height), control2: CGPoint(x: 0.17659*width, y: 0.8709*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.75187*height), control1: CGPoint(x: 0.03035*width, y: 0.83666*height), control2: CGPoint(x: 0, y: 0.79712*height))
        path.addLine(to: CGPoint(x: 0, y: 0.23712*height))
        path.closeSubpath()
        return path
    }
}
