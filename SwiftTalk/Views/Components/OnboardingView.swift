//
//  OnboardingView.swift
//  SwiftTalk
//
//  Created by Aman Bind on 20/05/25.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var currentPage = 0
    
    private let totalPages = 4

    var body: some View {
        if #available(iOS 18.0, *) {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack {
                    // Progress indicator
                    HStack {
                        ForEach(0..<totalPages, id: \.self) { index in
                            Capsule()
                                .fill(index <= currentPage ? Color.blue : Color.gray.opacity(0.3))
                                .frame(width: index == currentPage ? 24 : 8, height: 8)
                                .animation(.easeInOut(duration: 0.3), value: currentPage)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.horizontal)
                    
                    // Page content
                    TabView(selection: $currentPage) {
                        welcomePage.tag(0)
                        neuralVoicesPage.tag(1)
                        readingStatsPage.tag(2)
                        finalPage.tag(3)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .animation(.easeInOut, value: currentPage)
                }
            }
        } else {
            // Fallback for earlier versions
            VStack {
                welcomePage
            }
        }
    }

    // MARK: - Welcome Page
    private var welcomePage: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // App icon animation
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 120, height: 120)
                    .shadow(color: .blue.opacity(0.3), radius: 20, x: 0, y: 10)
                
                Image(systemName: "speaker.wave.3.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
            }
            
            VStack(spacing: 16) {
                Text("Welcome to SwiftTalk")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Transform any text into natural speech with advanced AI voices")
                    .font(.title3)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            
            Spacer()
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    currentPage = 1
                }
            }) {
                HStack {
                    Text("Get Started")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Image(systemName: "arrow.right")
                        .font(.headline)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(25)
                .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
        .padding()
    }

    // MARK: - Neural Voices Page
    private var neuralVoicesPage: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Feature icon
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(LinearGradient(
                        colors: [.orange.opacity(0.2), .red.opacity(0.2)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 120, height: 120)
                
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 50))
                    .foregroundColor(.orange)
            }
            .shadow(color: .orange.opacity(0.2), radius: 15, x: 0, y: 8)
            
            VStack(spacing: 16) {
                Text("Neural AI Voices")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Choose from dozens of realistic voices powered by advanced neural networks for the most natural listening experience")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            
            // Voice preview cards
            HStack(spacing: 12) {
                VoicePreviewCard(name: "Sarah", accent: "US English", color: .blue)
                VoicePreviewCard(name: "James", accent: "British", color: .green)
                VoicePreviewCard(name: "Elena", accent: "Spanish", color: .purple)
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            navigationButtons(
                onBack: { currentPage = 0 },
                onNext: { currentPage = 2 }
            )
        }
        .padding()
    }

    // MARK: - Reading Stats Page
    private var readingStatsPage: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Stats icon
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(LinearGradient(
                        colors: [.green.opacity(0.2), .mint.opacity(0.2)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 120, height: 120)
                
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(.system(size: 50))
                    .foregroundColor(.green)
            }
            .shadow(color: .green.opacity(0.2), radius: 15, x: 0, y: 8)
            
            VStack(spacing: 16) {
                Text("Track Your Progress")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Monitor your reading habits, track time spent, and see your progress with detailed statistics and insights")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            
            // Stats preview
            VStack(spacing: 16) {
                HStack(spacing: 20) {
                    StatPreviewCard(title: "Books Read", value: "24", icon: "book.fill", color: .blue)
                    StatPreviewCard(title: "Hours Listened", value: "156", icon: "clock.fill", color: .orange)
                }
                
                HStack(spacing: 20) {
                    StatPreviewCard(title: "Words/Min", value: "180", icon: "speedometer", color: .green)
                    StatPreviewCard(title: "Streak", value: "12 days", icon: "flame.fill", color: .red)
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            navigationButtons(
                onBack: { currentPage = 1 },
                onNext: { currentPage = 3 }
            )
        }
        .padding()
    }

    // MARK: - Final Page
    private var finalPage: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Success icon
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        colors: [.green, .mint],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 120, height: 120)
                    .shadow(color: .green.opacity(0.3), radius: 20, x: 0, y: 10)
                
                Image(systemName: "checkmark")
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.white)
            }
            
            VStack(spacing: 16) {
                Text("You're All Set!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Start reading with AI voices, track your progress, highlight PDFs, and unlock your full reading potential")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            
            // Feature highlights
            VStack(spacing: 12) {
                FeatureRow(icon: "doc.text.fill", title: "PDF Highlighting", color: .red)
                FeatureRow(icon: "waveform", title: "Audio Controls & Speed", color: .blue)
                FeatureRow(icon: "bookmark.fill", title: "Save & Resume Reading", color: .purple)
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
            Button(action: {
                UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                withAnimation(.easeInOut(duration: 0.5)) {
                    hasCompletedOnboarding = true
                }
            }) {
                HStack {
                    Text("Start Reading")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Image(systemName: "arrow.right")
                        .font(.headline)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(
                    LinearGradient(
                        colors: [.green, .mint],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(25)
                .shadow(color: .green.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 20)
            
            Button("Back") {
                withAnimation(.easeInOut(duration: 0.3)) {
                    currentPage = 2
                }
            }
            .foregroundColor(.secondary)
            .padding(.bottom, 40)
        }
        .padding()
    }

    // MARK: - Helper Views
    private func navigationButtons(onBack: @escaping () -> Void, onNext: @escaping () -> Void) -> some View {
        HStack {
            Button("Back") {
                withAnimation(.easeInOut(duration: 0.3)) {
                    onBack()
                }
            }
            .foregroundColor(.secondary)
            .frame(minWidth: 80, minHeight: 44)
            
            Spacer()
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    onNext()
                }
            }) {
                HStack {
                    Text("Next")
                        .fontWeight(.semibold)
                    
                    Image(systemName: "arrow.right")
                        .font(.caption)
                }
                .foregroundColor(.white)
                .frame(minWidth: 80, minHeight: 44)
                .background(Color.blue)
                .cornerRadius(22)
            }
        }
        .padding(.horizontal, 40)
        .padding(.bottom, 40)
    }
}

// MARK: - Supporting Views
struct VoicePreviewCard: View {
    let name: String
    let accent: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(color.opacity(0.2))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: "person.fill")
                        .foregroundColor(color)
                        .font(.system(size: 18))
                )
            
            Text(name)
                .font(.caption)
                .fontWeight(.semibold)
            
            Text(accent)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct StatPreviewCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(color)
            
            Text(value)
                .font(.headline)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, minHeight: 80)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(color)
                .frame(width: 24)
            
            Text(title)
                .font(.body)
                .foregroundColor(.primary)
            
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 18))
                .foregroundColor(.green)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 1)
    }
}

#Preview {
    OnboardingView(hasCompletedOnboarding: .constant(false))
}
