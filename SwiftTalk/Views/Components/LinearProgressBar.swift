//
//  LinearProgressBar.swift
//  SwiftTalk
//
//  Created by Aman Bind on 12/07/24.
//

import SwiftUI

struct LinearProgressBar: View {
    var value: Double
    var total: Double
    let color: Color

    var progress: CGFloat {
        return CGFloat(value) / CGFloat(total)
    }

    var body: some View {
        VStack {
            GeometryReader { geometry in

                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundColor(color.opacity(0.5))
                        .overlay {
                            HStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(color)
                                    .padding(2)
                                    .frame(width: max(geometry.size.width * progress, 12), height: 12)
                                    .animation(.easeInOut(duration: 0.5), value: progress)

                                Spacer(minLength: 0)
                            }
                        }
                }
                
            }
        }
        .frame(height: 12)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 30) {
        LinearProgressBar(value: 1, total: 50, color: .red)

            LinearProgressBar(value: 14, total: 50, color: .pink)

            LinearProgressBar(value: 21, total: 50, color: .green)

            LinearProgressBar(value: 28, total: 50, color: .mint)

            LinearProgressBar(value: 35, total: 50, color: .blue)

            LinearProgressBar(value: 42, total: 50, color: .purple)

            LinearProgressBar(value: 50, total: 50, color: .secondary)
        }
        .padding()
    }
}
