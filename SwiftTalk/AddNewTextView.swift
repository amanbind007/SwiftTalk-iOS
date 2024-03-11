//
//  NewTextView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 08/03/24.
//

import SwiftUI

struct AddNewTextView: View {
    @State private var text = ""
    
    @Environment(\.colorScheme) private var theme
    
    init(){
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: "AbrilFatface-Regular", size: 25)!]
    }
    
    var body: some View {
        NavigationView(content: {
            VStack {
                Divider()
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    
                    //.background()
            }
            .navigationTitle("SwiftTalk")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem {
                    Button(action:  {
                        
                    }, label: {
                        Text("Save")
                    })
                }
            })
            .background(
                Color.red
            )
            
        })
        .presentationCornerRadius(25)
        
        
    }
        
}

#Preview {
    AddNewTextView()
}
