//
//  FontSelectorView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 08/07/24.
//

import SwiftUI

struct FontSelectorView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedfont: String

    var body: some View {
        List {
            Section {
                ForEach(Constants.BionicFonts.allFonts, id: \.self) { font in
                    HStack {
                        Text(font)
                            .font(.custom(font, size: 16))

                        Spacer()

                        Image(systemName: selectedfont == font ? "checkmark.circle.fill" : "circle.fill")
                            .foregroundStyle(selectedfont == font ? .green : .secondary)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedfont = font
                        dismiss()
                    }
                }

            } header: {
                Text("Bionic Font")
            } footer: {
                Text("Bionic reading speeds up reading by highlighting key parts, guiding your eyes move more efficiently across the text, reducing wasted effort")
            }

            Section {
                ForEach(Constants.OpenDislexic.allFonts, id: \.self) { font in

                    HStack {
                        Text(font)
                            .font(.custom(font, size: 16))

                        Spacer()

                        Image(systemName: selectedfont == font ? "checkmark.circle.fill" : "circle.fill")
                            .foregroundStyle(selectedfont == font ? .green : .secondary)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedfont = font
                        dismiss()
                    }
                }
            } header: {
                Text("OpenDislexic Font")
            } footer: {
                Text("OpenDyslexic is a font designed for dyslexia. It has weighted bottoms to help people with dyslexia recognize letters and prevent confusion.")
            }

            ForEach(UIFont.familyNames, id: \.self) { family in

                Section(header: Text(family)) {
                    ForEach(UIFont.fontNames(forFamilyName: family), id: \.self) { font in
                        HStack {
                            Text(font)
                                .font(.custom(font, size: 16))

                            Spacer()

                            Image(systemName: selectedfont == font ? "checkmark.circle.fill" : "circle.fill")
                                .foregroundStyle(selectedfont == font ? .green : .secondary)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedfont = font
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    FontSelectorView(selectedfont: .constant(Constants.BionicFonts.BionicSerif))
}
