//
//  SearchView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 10/03/24.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    
    @State private var isAnimationOn: Bool = false
    
    @FocusState var focus: FocusedField?
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .padding(.leading, 9)
                    .foregroundStyle(.gray)
                TextField("Search", text: $searchText)
                    .padding(.vertical, 10)
                    .font(.custom(Constants.Fonts.NotoSerifR, size: 18))
                    .autocorrectionDisabled()
                    .keyboardType(.default)
                    .focused($focus, equals: .search)
                
                Spacer()
                
                if focus == FocusedField.search {
                    Button(action: {
                        searchText = ""
                        
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .padding(.trailing, 9)
                            .foregroundStyle(searchText.isEmpty ? .gray : .red)
                        
                    })
                    .disabled(searchText.isEmpty ? true : false)
                }
            }
            .overlay {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(lineWidth: 4)
                    .fill(
                        LinearGradient(colors: isAnimationOn ? [.pink, .purple] : [.purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .onAppear(perform: {
                        withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
                            isAnimationOn.toggle()
                        }
                    })
            }
            .background(Color.accent2)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            
            
            if focus != nil {
                Button("Cancel", role: .cancel) {
                    withAnimation(.linear(duration: 1)) {
                        focus = nil
                        searchText = ""
                    }
                }
            }
        }
        
        .padding()
    }
}

#Preview {
    SearchView(searchText: .constant(""))
}
