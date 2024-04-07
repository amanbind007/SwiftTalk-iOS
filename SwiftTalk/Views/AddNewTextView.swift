//
//  NewTextView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 08/03/24.
//

import AVFoundation
import SwiftUI

struct AddNewTextView: View {
    @State private var title = ""
    @State private var isPlaying = false
    @State private var isPopoverPresented = false
    
    let pasteboard = UIPasteboard.general
    
    @State private var text = """
    
    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.

    Why do we use it?
    It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).


    Where does it come from?
    Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.

    The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.

    Where can I get some?
    There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.
    """

    @Environment(\.colorScheme) private var theme
    @Environment(\.dismiss) private var dismiss
    
    @State var degreesRotating = 0.0
    
    var body: some View {
        VStack {
            // TextFileds for title and Contents
            
            VStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(
                        LinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing)
                    )
                HStack {
                    Text("Title:")
                        .font(.custom(Constants.Fonts.NotoSerifR, size: 18))
                    TextField("", text: $title)
                        .font(.custom(Constants.Fonts.NotoSerifR, size: 18))
                }
                .scrollContentBackground(.hidden)
                
                .padding(.horizontal, 5)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(
                        LinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing)
                    )
                TextEditor(text: $text)
                    .font(.custom(Constants.Fonts.NotoSerifR, size: 18))
            }
            
            // Bottom Control Panel
            
            VStack {
                HStack {
                    ZStack {
                        RippledCircle()
                            
                            .fill(LinearGradient(colors: [.pink, .blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 55, height: 55)
                            .rotationEffect(.degrees(degreesRotating))
                            .onAppear(perform: {
                                withAnimation(.linear(duration: 1)
                                    .speed(0.5).repeatForever(autoreverses: false))
                                {
                                    degreesRotating = 360.0
                                }
                                
                            })
                            .onTapGesture {
                                isPopoverPresented.toggle()
                            }
                        
                        Image("myPhoto2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45, height: 45)
                            .clipShape(Circle())
                    }
                    .popover(isPresented: $isPopoverPresented, content: {
                        VoiceSelectorView()
                            .presentationCompactAdaptation(.automatic)
                    })
                    
                    Spacer()
                    
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(isPlaying ? .red : .blue)
                        .clipShape(Circle())
                        .onTapGesture {
                            withAnimation {
                                isPlaying.toggle()
                            }
                        }
                    
                    Spacer()
                }
                .padding(8)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("SwiftTalk")
        .navigationBarBackButtonHidden()
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(role: .cancel) {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            }
            
            ToolbarItemGroup {
                HStack {
                    Button(role: .destructive) {
                        text = ""
                    } label: {
                        Image(Constants.Icons.backspaceicon)
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    
                    Button(role: .none) {
                        text = pasteboard.string!
                    } label: {
                        Image(Constants.Icons.clipboardIcon)
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    
                    Button {
                        // Save the text in persistence storage and dismiss View
                        
                        dismiss()
                    } label: {
                        Image(Constants.Icons.saveIcon)
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                }
            }
            
        })
    }
}

#Preview {
    NavigationStack {
        AddNewTextView()
    }
}
