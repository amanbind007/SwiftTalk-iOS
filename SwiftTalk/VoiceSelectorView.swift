//
//  VoiceSelectorView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 14/03/24.
//

import SwiftUI

struct VoiceSelectorView: View {
    @State var animateRotation = false
    
    var body: some View {
        List {
            HStack {
                Image("india_flag")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                
                Divider()
                ZStack {
                    RippledCircle()
                        
                        .fill(LinearGradient(colors: [.pink, .blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 30, height: 30)
                        .rotationEffect(.degrees(animateRotation ? 180 : 0))
                        .onAppear(perform: {
                            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                                animateRotation.toggle()
                            }
                        })
                    
//                    LinearGradient(colors: [.pink, .blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
//                        .hueRotation(.degrees(animateGradient ? 45 : 0))
//                        .clipShape(RippledCircle()
//
//                        )
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 30, height: 30)
                    ////                        .onAppear(perform: {
                    ////                            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                    ////                                animateGradient.toggle()
                    ////                            }
                    ////                        })
                    
                    Image("myPhoto2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                    
                        .clipShape(RippledCircle())
                }
                
                Text("Vinnet")
                
                Spacer()
                
                Image(systemName: "circle")
            }
        }
    }
}

#Preview {
    VoiceSelectorView()
}
