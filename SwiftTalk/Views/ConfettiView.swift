//
//  ConfettiView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 17/07/24.
//

import Lottie
import SpriteKit
import SwiftUI

struct ConfettiView: View {
    @Binding var isFinishedReading: Bool
    @Binding var textData: TextData

    var body: some View {
        if isFinishedReading && !textData.isCompleted {
            ZStack {
                GeometryReader(content: { geometry in
                    SpriteView(scene: ConfettiScene(size: geometry.size), options: [.allowsTransparency])
                        .ignoresSafeArea()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                })
                VStack {
                    LottieView(animation: .named("Completed"))
                        .playing(loopMode: .loop)
                        .shadow(color: .white, radius: 30)
                        .offset(y: -70)

                    LottieView(animation: .named("CompleteAnimation"))
                        .playing(loopMode: .playOnce)

                        .shadow(color: .white, radius: 30)
                        .frame(width: 350, height: 350)
                        .offset(y: -100)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .background {
                Color.black.opacity(0.2)
                    .ignoresSafeArea()
            }
            .onTapGesture {
                textData.isCompleted = true
                textData.progress = textData.text.count
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                    withAnimation {
                        textData.isCompleted = true
                        textData.progress = textData.text.count
                    }
                }
            }
        }
    }
}

#Preview {
    ConfettiView(isFinishedReading: .constant(true), textData: .constant(TextDataPreviewProvider.textData1))
}
