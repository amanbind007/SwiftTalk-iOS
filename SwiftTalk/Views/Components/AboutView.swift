//
//  AboutView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 14/10/24.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            HeaderView()

            VStack(alignment: .leading, spacing: 20) {

                ContentSection(title: "About SwiftTalk App", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor, nunc id aliquam tincidunt, nisl nunc tincidunt nunc, vitae aliquam nunc nunc vitae nunc.")

                ContentSection(title: "Features", content: "• Praesent in mauris eu tortor porttitor accumsan.\n• Mauris sollicitudin fermentum libero.\n• Pellentesque auctor neque nec urna.\n• Sed hendrerit.")

                ContentSection(title: "Privacy Policy", content: "Curabitur ligula sapien, tincidunt non, euismod vitae, posuere imperdiet, leo. Maecenas malesuada. Praesent congue erat at massa.")

                FooterView()
            }
            .padding()
        }
    }
}

struct HeaderView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image(uiImage: UIImage.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90, height: 90)
                .foregroundColor(.blue)

            Text("SwiftTalk")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(Bundle.main.appVersionShort)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

struct ContentSection: View {
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)

            Text(content)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

struct FooterView: View {
    var body: some View {
        VStack {
            Divider()

            Text("2024 Developer - Aman Bind")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding(.top)
    }
}

#Preview {
    AboutView()
}
