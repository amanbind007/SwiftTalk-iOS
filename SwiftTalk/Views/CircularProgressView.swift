//
//  CircularProgressView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 11/07/24.
//

import SwiftUI

struct CircularProgressView: View {
    var value: Int
    var total: Int
    
    let color: Color
    
    let image: String
    
    init(value: Int, total: Int, color: Color, image: String) {
        self.value = value
        self.total = total
        self.color = color
        self.image = image
    }
    
    var progress: CGFloat {
        return CGFloat(value) / CGFloat(total)
    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(
                        color.opacity(0.2),
                        lineWidth: 12
                    )
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        color,
                        style: StrokeStyle(
                            lineWidth: 8,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: progress)
                    .overlay {
                        Image(image)
                            .resizable()
                            .clipShape(Circle())
                        
                            .padding(9)
                    }
            }
        }
//        .frame(width: 60, height: 60)
    }
}

#Preview {
    VStack {
        Grid {
            GridRow {
                CircularProgressView(value: 7, total: 50, color: .pink, image: Constants.Icons.cameraIcon)
                    .padding(5)
                
                CircularProgressView(value: 14, total: 50, color: .green, image: Constants.Icons.imageFileIcon)
                    .padding(5)
                
                CircularProgressView(value: 21, total: 50, color: .red, image: Constants.Icons.pdfFileIcon)
                    .padding(5)
            }
            GridRow {
                CircularProgressView(value: 28, total: 50, color: .purple, image: Constants.Icons.textFileInputIcon)
                    .padding(5)
                CircularProgressView(value: 35, total: 50, color: .mint, image: Constants.Icons.webIcon)
                    .padding(5)
                CircularProgressView(value: 42, total: 50, color: .blue, image: Constants.Icons.wordFileIcon)
                    .padding(5)
            }
            
            GridRow {
                CircularProgressView(value: 49, total: 50, color: .gray, image: Constants.Icons.textFileIcon)
                    .padding(5)
            }
        }
    }
}
