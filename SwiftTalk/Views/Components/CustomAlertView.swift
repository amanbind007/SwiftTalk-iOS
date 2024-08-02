//
//  CustomAlertView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 04/07/24.
//

import SwiftUI

struct CustomAlertView: View {
    @Binding var isPresented: Bool
    @Binding var newTitle: String
    @Binding var isCorrect: Bool

    var onSave: () -> Void

    var body: some View {
        if isPresented {
            VStack(spacing: 0) {
                Text("Enter new title")
                    .font(NotoFont.SemiBold(18))
                    .padding()

                TextField("Enter new title", text: $newTitle)
                    .padding(2)
                    .textFieldStyle(.roundedBorder)
                    .font(NotoFont.Regular(14))
                    .cornerRadius(5)
                    .shadow(color: isCorrect ? .clear : .red, radius: 5)
                    .padding([.horizontal, .bottom])

                Divider()

                HStack(spacing: 0) {
                    Button {
                        isPresented = false
                    } label: {
                        Text("Cancel")
                            .font(NotoFont.SemiBold(16))
                            .foregroundColor(.pink)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    }
                    Divider()
                        .frame(minWidth: 0, maxWidth: 0.5, minHeight: 0, maxHeight: .infinity)

                    Button {
                        onSave()
                    } label: {
                        Text("OK")
                            .font(NotoFont.SemiBold(16))
                            .foregroundColor(.accentColor)
                            .multilineTextAlignment(.center)
                            .padding(15)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 55)
                .padding([.horizontal, .bottom], 0)
            }
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .shadow(radius: 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .toolbar(.hidden, for: .tabBar)
            .background(
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPresented = false
                    }
            )
        }
    }
}

#Preview {
    CustomAlertView(isPresented: .constant(true), newTitle: .constant("Title Test"), isCorrect: .constant(false), onSave: {
        print()
    })
}
