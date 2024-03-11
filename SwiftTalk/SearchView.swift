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
                    .font(.custom("NotoSerif-Regular", size: 18))
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
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 3)
                    .fill(
                        LinearGradient(colors: isAnimationOn ? [.blue, .green] : [.green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .onAppear(perform: {
                        withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
                            isAnimationOn.toggle()
                        }
                    })
            }
            
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

//#Preview {
//    SearchView(searchText: .constant(""), focusedField: )
//}
