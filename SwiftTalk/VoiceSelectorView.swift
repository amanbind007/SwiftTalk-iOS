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
                Image("flag_check")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                
                Divider()
                
                ZStack {
                    HexagonShape()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundStyle(
                            LinearGradient(colors: [.indigo, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                    
                    Text("EN")
                        .font(.custom("ChangaOne", size: 14))
                        .foregroundStyle(Color.white)
                }
                
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
                    
                    Image("myPhoto2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                    
                        .clipShape(RippledCircle())
                }
                
                Text("Vinnet")
                    .font(.custom(Constants.Fonts.NotoSerifR, size: 14))
                
                Spacer()
                
                Image(systemName: "circle")
            }
        }
    }
}

#Preview {
    VoiceSelectorView()
}
