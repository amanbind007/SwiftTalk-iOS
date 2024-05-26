//
//  VoiceSelectorView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 14/03/24.
//

import SwiftUI

struct VoiceSelectorView: View {
    @Environment(\.dismiss) var dismiss

    let voices: [Voice] = [
        Voice(languageCode: "ar-001", voiceName: "Majed", flagName: "saudi-arabia-flag-round-circle-icon", country: "Saudi Arabia", language: "AR", demoText: "مرحبا بالعالم! هذا هو صوت م أجِد لتجربة ميزة تحويل النص إلى كلام"),
        Voice(languageCode: "bg-BG", voiceName: "Daria", flagName: "bulgaria-flag-round-circle-icon", country: "Bulgaria", language: "BG", demoText: "Здравейте света! Това е гласът на Дария за вашето изживяване с текст към говор."),
        Voice(languageCode: "ca-ES", voiceName: "Montse", flagName: "spain-country-flag-round-icon", country: "Spain", language: "CA", demoText: "¡Hola mundo! Esta es la voz de Montse para tu experiencia de texto a voz."),
        Voice(languageCode: "cs-CZ", voiceName: "Zuzana", flagName: "czech-republic-flag-round-circle-icon", country: "Czech Republic", language: "CS", demoText: "Ahoj světe! Toto je Zuzanin hlas pro vaši zkušenost s převáděním textu na řeč."),
        Voice(languageCode: "da-DK", voiceName: "Sara", flagName: "denmark-flag-round-circle-icon", country: "Denmark", language: "DA", demoText: "Hej verden! Dette er Saras stemme til din tekst-til-tale-oplevelse."),
        Voice(languageCode: "de-DE", voiceName: "Anna", flagName: "germany-flag-round-circle-icon", country: "Germany", language: "DE", demoText: "Hallo Welt! Dies ist Annas Stimme für Ihr Text-zu-Sprache-Erlebnis."),
        Voice(languageCode: "el-GR", voiceName: "Melina", flagName: "greece-flag-round-circle-icon", country: "Greece", language: "EL", demoText: "Γεια σας στον κόσμο! Αυτή είναι η φωνή της Melina για την εμπειρία σας με την μετατροπή κειμένου σε ομιλία."),
        Voice(languageCode: "en-AU", voiceName: "Karen", flagName: "australia-flag-round-circle-icon", country: "Australia", language: "EN", demoText: "Hello world! This is Karen's voice for your text-to-speech experience."),
        Voice(languageCode: "en-GB", voiceName: "Daniel", flagName: "uk-flag-round-circle-icon", country: "United Kingdom", language: "EN", demoText: "Hello world! This is Deniel's voice for your text-to-speech experience."),
        Voice(languageCode: "en-IE", voiceName: "Moira", flagName: "ireland-flag-round-circle-icon", country: "Ireland", language: "EN", demoText: "Hello world! This is Moira's voice for your text-to-speech experience."),
        Voice(languageCode: "en-IN", voiceName: "Rishi", flagName: "india-flag-round-circle-icon", country: "India", language: "EN", demoText: "Hello world! This is Rishi's voice for your text-to-speech experience."),
        Voice(languageCode: "en-US", voiceName: "Trinoids", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN", demoText: "Hello world! This is Trinoid's voice for your text-to-speech experience."),
        Voice(languageCode: "en-US", voiceName: "Albert", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN", demoText: "Hello world! This is Albert's voice for your text-to-speech experience."),
        Voice(languageCode: "en-US", voiceName: "Jester", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN", demoText: "Hello world! This is Jester's voice for your text-to-speech experience."),
        Voice(languageCode: "en-US", voiceName: "Samantha", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN", demoText: "Hello world! This is Samantha's voice for your text-to-speech experience."),
        Voice(languageCode: "en-US", voiceName: "Whisper", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN", demoText: "Hello world! This is whispering voice for your text-to-speech experience."),
        Voice(languageCode: "en-US", voiceName: "Superstar", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN", demoText: "Hello world! This is Superstar's voice for your text-to-speech experience."),
        Voice(languageCode: "en-US", voiceName: "Bells", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN", demoText: "Hello world! This is Bell's voice for your text-to-speech experience."),
        Voice(languageCode: "en-US", voiceName: "Organ", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN", demoText: "Hello world! This is Organ's voice for your text-to-speech experience."),
        Voice(languageCode: "en-US", voiceName: "Bad News", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN", demoText: "Hello world! This is Bad News voice for your text-to-speech experience."),
        Voice(languageCode: "en-US", voiceName: "Bubbles", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN", demoText: "Hello world! This is Bubbles voice for your text-to-speech experience."),
        Voice(languageCode: "en-US", voiceName: "Junior", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN", demoText: "Hello world! This is Junior's voice for your text-to-speech experience."),
        Voice(languageCode: "en-US", voiceName: "Bahh", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN", demoText: "Hello world! This is Bahh voice for your text-to-speech experience."),
        Voice(languageCode: "en-US", voiceName: "Wobble", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN", demoText: "Hello world! This is wobbling voice for your text-to-speech experience."),
        Voice(languageCode: "en-US", voiceName: "Boing", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN", demoText: "Hello world! This is Boing voice for your text-to-speech experience."),
        Voice(languageCode: "en-US", voiceName: "Good News", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN", demoText: "Hello world! This is Good News voice for your text-to-speech experience."),
        Voice(languageCode: "en-US", voiceName: "Zarvox", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN", demoText: "Hello world! This is Zervox's voice for your text-to-speech experience."),
        Voice(languageCode: "en-US", voiceName: "Ralph", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN", demoText: "Hello world! This is Ralph's voice for your text-to-speech experience."),
        Voice(languageCode: "en-US", voiceName: "Cellos", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN", demoText: "Hello world! This is Cellos voice for your text-to-speech experience."),
        Voice(languageCode: "en-US", voiceName: "Kathy", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN", demoText: "Hello world! This is Kathy's voice for your text-to-speech experience."),
        Voice(languageCode: "en-US", voiceName: "Fred", flagName: "usa-flag-round-circle-icon", country: "United States", language: "EN", demoText: "Hello world! This is Fred's voice for your text-to-speech experience."),
        Voice(languageCode: "en-ZA", voiceName: "Tessa", flagName: "south-africa-flag-round-circle-icon", country: "South Africa", language: "EN", demoText: "Hello world! This is Tessa's voice for your text-to-speech experience."),
        Voice(languageCode: "es-ES", voiceName: "Mónica", flagName: "spain-country-flag-round-icon", country: "Spain", language: "ES", demoText: "¡Hola mundo! Esta es la voz de Mónica para tu experiencia de texto a voz."),
        Voice(languageCode: "es-MX", voiceName: "Paulina", flagName: "mexico-flag-round-circle-icon", country: "Mexico", language: "ES", demoText: "¡Hola mundo! Esta es la voz de Paulina para tu experiencia de texto a voz."),
        Voice(languageCode: "fi-FI", voiceName: "Satu", flagName: "finland-flag-round-circle-icon", country: "Finland", language: "FI", demoText: "Hei maailma! Tämä on Satun ääni tekstistä puheeksi -kokemuksellesi."),
        Voice(languageCode: "fr-CA", voiceName: "Amélie", flagName: "canada-flag-round-circle-icon", country: "Canada", language: "FR", demoText: "Bonjour le monde! Ceci est la voix d'Amélie pour votre expérience de text-to-speech."),
        Voice(languageCode: "fr-FR", voiceName: "Thomas", flagName: "france-flag-round-circle-icon", country: "France", language: "FR", demoText: "Bonjour le monde! Ceci est la voix de Thomas pour votre expérience de text-to-speech."),
        Voice(languageCode: "he-IL", voiceName: "Carmit", flagName: "israel-flag-round-circle-icon", country: "Israel", language: "HE", demoText: "שלום עולם! זהו קולה של קרמית עבור חווית טקסט לדיבור שלך."),
        Voice(languageCode: "hi-IN", voiceName: "Lekha", flagName: "india-flag-round-circle-icon", country: "India", language: "HI", demoText: "नमस्ते दुनिया! यह आपके टेक्स्ट-टू-स्पीच अनुभव के लिए लेखा की आवाज है।"),
        Voice(languageCode: "hr-HR", voiceName: "Lana", flagName: "croatia-flag-round-circle-icon", country: "Croatia", language: "HR", demoText: "Pozdrav svijete! Ovo je Lanin glas za vaše iskustvo pretvaranja teksta u govor."),
        Voice(languageCode: "hu-HU", voiceName: "Tünde", flagName: "hungary-flag-round-circle-icon", country: "Hungary", language: "HU", demoText: "Helló Világ! Ez Tünde hangja a szövegfelolvasó élményedért."),
        Voice(languageCode: "id-ID", voiceName: "Damayanti", flagName: "indonesia-flag-round-circle-icon", country: "Indonesia", language: "ID", demoText: "Selamat dunia! Ini adalah suara Dayamanti untuk pengalaman teks-ke-ucapan Anda."),
        Voice(languageCode: "it-IT", voiceName: "Alice", flagName: "italy-flag-round-circle-icon", country: "Italy", language: "IT", demoText: "Ciao mondo! Questa è la voce di Alice per la tua esperienza di testo parlato."),
        Voice(languageCode: "ja-JP", voiceName: "Kyoko", flagName: "japan-flag-round-circle-icon", country: "Japan", language: "JA", demoText: "こんにちは世界！これは音声合成のデモです"),
        Voice(languageCode: "ko-KR", voiceName: "Yuna", flagName: "south-korea-flag-round-circle-icon", country: "South Korea", language: "KO", demoText: "안녕하세요! 텍스트 음성 변환을 위한 유나의 목소리입니다."),
        Voice(languageCode: "ms-MY", voiceName: "Amira", flagName: "malaysia-flag-round-circle-icon", country: "Malaysia", language: "MS", demoText: "Selamat dunia! Ini adalah suara Amira untuk pengalaman teks-ke-ucapan anda."),
        Voice(languageCode: "nb-NO", voiceName: "Nora", flagName: "norway-flag-round-circle-icon", country: "Norway", language: "NB", demoText: "Hei verden! Dette er Noras stemme for din tekst-til-tale-opplevelse."),
        Voice(languageCode: "nl-BE", voiceName: "Ellen", flagName: "belgium-flag-round-circle-icon", country: "Belgium", language: "NL", demoText: "Hallo wereld! Dit is de stem van Ellen voor uw tekst-naar-spraak-ervaring."),
        Voice(languageCode: "nl-NL", voiceName: "Xander", flagName: "netherlands-flag-round-circle-icon", country: "Netherlands", language: "NL", demoText: "Hallo wereld! Dit is de stem van Xander voor uw tekst-naar-spraak-ervaring."),
        Voice(languageCode: "pl-PL", voiceName: "Zosia", flagName: "poland-flag-round-circle-icon", country: "Poland", language: "PL", demoText: "Witaj świecie! To jest głos Zosia dla Twojego doświadczenia tekst-mowa."),
        Voice(languageCode: "pt-BR", voiceName: "Luciana", flagName: "brazil-flag-round-circle-icon", country: "Brazil", language: "PT", demoText: "Olá mundo! Esta é a voz do Luciana para a sua experiência de texto para voz."),
        Voice(languageCode: "pt-PT", voiceName: "Joana", flagName: "portugal-flag-round-circle-icon", country: "Portugal", language: "PT", demoText: "Olá mundo! Esta é a voz do Joana para a sua experiência de texto para voz."),
        Voice(languageCode: "ro-RO", voiceName: "Ioana", flagName: "romania-flag-round-circle-icon", country: "Romania", language: "RO", demoText: "Salut lume! Aceasta este vocea lui Ioana pentru experiența dvs. text-to-speech."),
        Voice(languageCode: "ru-RU", voiceName: "Milena", flagName: "russia-flag-round-circle-icon", country: "Russia", language: "RU", demoText: "Привет мир! Это голос Milena для вашего текстового опыта."),
        Voice(languageCode: "sk-SK", voiceName: "Laura", flagName: "slovakia-flag-round-circle-icon", country: "Slovakia", language: "SK", demoText: "Ahoj svet! Toto je hlas Laura pre vašu skúsenosť s textom na reč."),
        Voice(languageCode: "sv-SE", voiceName: "Alva", flagName: "sweden-flag-round-circle-icon", country: "Sweden", language: "SV", demoText: "Hej världen! Detta är rösten för Alva för din text-till-tal-upplevelse."),
        Voice(languageCode: "th-TH", voiceName: "Kanya", flagName: "thailand-flag-round-circle-icon", country: "Thailand", language: "TH", demoText: "สวัสดีค่ะ โลก! นี่คือเสียงของ กัญญา สำหรับประสบการณ์การแปลงข้อความเป็นเสียงของคุณ."),
        Voice(languageCode: "tr-TR", voiceName: "Yelda", flagName: "turkey-flag-round-circle-icon", country: "Turkey", language: "TR", demoText: "Selam Dünya! bu Yelda'nın sesi metinden konuşmaya deneyiminiz içindir."),
        Voice(languageCode: "uk-UA", voiceName: "Lesya", flagName: "ukraine-flag-round-circle-icon", country: "Ukraine", language: "UK", demoText: "Привіт Світ! Це голос Лесі для вашого досвіду текстових повідомлень."),
        Voice(languageCode: "vi-VN", voiceName: "Linh", flagName: "vietnam-flag-round-circle-icon", country: "Vietnam", language: "VI", demoText: "Привіт Світ! це голос Ліна для вашого досвіду синтезу мовлення"),
        Voice(languageCode: "zh-CN", voiceName: "Tingting", flagName: "china-flag-round-circle-icon", country: "China", language: "ZH", demoText: "你好世界！這是婷婷的聲音，為您提供文字轉語音的體驗。"),
        Voice(languageCode: "zh-HK", voiceName: "Sinji", flagName: "hong-kong-flag-round-circle-icon", country: "Hong Kong", language: "ZH", demoText: "你好世界！這是真嗣的聲音，為您提供文字轉語音的體驗。"),
        Voice(languageCode: "zh-TW", voiceName: "Meijia", flagName: "taiwan-flag-round-circle-icon", country: "Taiwan", language: "ZH", demoText: "你好世界！ 這是美嘉的聲音，為您提供文字轉語音的體驗。")
    ]

    var body: some View {
        NavigationStack {
            List {
                ForEach(voices) { voice in
                    VoiceSelectorListItemView(voice: voice)
                }
            }
            .navigationTitle("Select Voice")
            .navigationBarTitleDisplayMode(.inline)
            .offset(y: -25)
            .ignoresSafeArea(edges: [.bottom])
            .toolbar(content: {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.custom(Constants.Fonts.NotoSerifR, size: 16))
                }
            })
        }
    }
}

#Preview {
    VoiceSelectorView()
}
