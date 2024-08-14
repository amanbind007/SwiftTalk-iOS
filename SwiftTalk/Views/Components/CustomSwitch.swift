//
//  CustomSwitch.swift
//  SwiftTalk
//
//  Created by Aman Bind on 23/06/24.
//

import SwiftUI

struct CustomSwitch: View {
    @Binding var isOn: Bool
    @Binding var showEditAlert: Bool

    var body: some View {
        ZStack(alignment: isOn ? .leading : .trailing) {
            Capsule()
                .frame(width: 70, height: 34)
                .foregroundColor(isOn ? .green.opacity(0.5) : .red.opacity(0.5))

            Text("Edit")
                .offset(x: isOn ? 5 : -5)
                .font(NotoFont.Regular(16))

            ZStack {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                Image(systemName: isOn ? "pencil" : "pencil.slash")
                    .foregroundStyle(Color.black)
            }
            .shadow(color: .black.opacity(0.14), radius: 4, x: 0, y: 2)
            .offset(x: isOn ? 38 : -38)
            .animation(.spring, value: isOn)
        }
        .onTapGesture {
            if isOn {
                isOn = false
            } else {
                showEditAlert = true
            }
        }
    }
}

#Preview {
    HStack {
        CustomSwitch(isOn: .constant(true), showEditAlert: .constant(true))
    }
}
