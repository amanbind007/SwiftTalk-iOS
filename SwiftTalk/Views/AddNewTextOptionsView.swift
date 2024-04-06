//
//  AddNewTextOptionsView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 11/03/24.
//

import SwiftUI

struct AddNewTextOptionsView: View {
    let viewModel: NavigationStateViewModel
    @State private var selectedOption: AddNewTextOption?

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer(minLength: 44)
                    // List of Options for adding text
                    ScrollView {
                        ForEach(AddNewTextOption.allCases) { option in
                            Button(action: {
                                self.viewModel.showAddNewTextOptionsView = false
                                self.viewModel.targetDestination.append(option)
                            }) {
                                AddNewTextOptionCardView(title: option.title, description: option.description, imageName: option.imageName)
                                    .padding([.top], 2)
                            }
                        }
                        .offset(y: 8)
                        Spacer()
                    }
                    .background(
                        Color.accent2
                    )
                }

                // Custom Top Bar View
                VStack {
                    VStack {
                        HStack {
                            Text("Add Text")
                                .font(.custom(Constants.Fonts.AbrilFatfaceR, size: 20))
                                .offset(y: 10)
                        }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(
                                LinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing)
                            )
                    }
                    .background(Material.ultraThin)

                    Spacer()
                }
            }
        }
    }
}


#Preview {
    AddNewTextOptionsView(viewModel: NavigationStateViewModel())
}
