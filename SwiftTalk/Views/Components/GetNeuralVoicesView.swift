//
//  GetNeuralVoicesView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 12/09/24.
//

import SwiftUI
import YouTubePlayerKit

struct GetNeuralVoicesView: View {
    let videoLink = "https://www.youtube.com/shorts/LyV7FNh3sDM"
    var body: some View {
        List {
            Section {
                HStack {
                    Image(uiImage: UIImage(named: "SettingsIcon")!)
                        .resizable()
                        .frame(width: 35, height: 35)
                    Text("Go to settings")
                }
            } footer: {
                
            }
            
            Section {
                HStack {
                    Image(uiImage: UIImage(named: "AccessibilityIcon")!)
                        .resizable()
                        .frame(width: 35, height: 35)
                    Text("Go to Accessibility")
                }
            }
            
            Section {
                HStack {
                    Image(uiImage: UIImage(named: "LiveSpeechIcon")!)
                        .resizable()
                        .frame(width: 35, height: 35)
                    Text("Go to Live Speech")
                }
            }
            
            Section{
                Text("Select any voice in VOICES Section")
                HStack{
                    Image(uiImage: UIImage.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            
            Section{
                Text("Select voice of your choice from all the languages available")
                HStack{
                    Image(uiImage: UIImage.image2)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            
            Section{
                Text("Download the premium and enhanced voices according to your preference")
                HStack{
                    Image(uiImage: UIImage.image3)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            
            Section{
                Text("Once downloaded, it will appear in the voices lis of the app")
                HStack{
                    Image(uiImage: UIImage.image4)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            
            Section{
                HStack{
                    Text("Icon Meaning")
                        .bold()
                }
                HStack{
                    Image(uiImage: UIImage.eStar)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                    
                    Text("Enhanced Voice (Good)")
                }
                HStack{
                    Image(uiImage: UIImage.pStar)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                    
                    Text("Premium Voice (Better)")
                }
            }
        }
    }
}

#Preview {
    GetNeuralVoicesView()
}
