//
//  CustomTabView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 03/08/24.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack {
            Capsule()
                .foregroundStyle(Material.thick)
            Capsule(style: .circular)
                .foregroundStyle(Material.ultraThinMaterial)
                .padding(5)
                .frame(width: 200)
                .offset(x: selectedTab == 0 ? -80 : 80)
            
            HStack {
                Spacer()
                Button {
                    selectedTab = 0
                } label: {
                    Label("Home", systemImage: "house.fill")
                        .imageScale(.large)
                }

                Spacer()
                Spacer()
                
                Button(action: {
                    selectedTab = 1
                }, label: {
                    Label("Stats", systemImage: "chart.bar.xaxis")
                        .imageScale(.large)
                })
                
                Spacer()
            }
            .foregroundStyle(Color.deepOrange)
        }
        .animation(.spring, value: selectedTab)
        .padding(.horizontal)
        .frame(height: 60)
    }
}

#Preview {
    CustomTabView(selectedTab: .constant(0))
}
