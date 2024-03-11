//
//  SearchView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 10/03/24.
//

import SwiftUI

struct SearchView: View {
    enum FocusedField {
        case search
    }

    @State private var searchText: String = ""
    
    @State private var isOn: Bool = false
    
    @FocusState private var focusedField: FocusedField?
    
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
                    .focused($focusedField, equals: .search)
                
                Spacer()
                
                if focusedField == .search {
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
                        LinearGradient(colors: isOn ? [.blue, .green] : [.green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .onAppear(perform: {
                        withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
                            isOn.toggle()
                        }
                    })
            }
            
            if focusedField != nil {
                Button("Cancel", role: .cancel) {
                    withAnimation(.linear(duration: 1)) {
                        focusedField = nil
                        searchText = ""
                    }
                }
            }
        }
        
        .padding()
    }
}

#Preview {
    SearchView()
}
