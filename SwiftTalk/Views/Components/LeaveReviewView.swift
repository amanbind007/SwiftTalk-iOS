//
//  LeaveReviewView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 10/09/24.
//

import SwiftUI
import StoreKit

public struct LeaveReviewView: View {
    var label: String
    
    @State private var isPushed = false
    
    public init(label: String) {
        self.label = label
    }
    
    public var body: some View {
        
        Button(action: {
            guard let currentScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return
            }
            
            SKStoreReviewController.requestReview(in: currentScene)
        }, label: {
            HStack{
                Text(label)
//                    .font(.callout.weight(.medium))
//                Spacer()
//                Image(systemName: "chevron.right")
            }
        })
        
        
        
    }
    
    
}

#Preview {
    LeaveReviewView(label: "Leave Review")
}
