import SwiftUI

struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var currentPage = 0
    
    var body: some View {
        TabView(selection: $currentPage) {
            welcomePage
                .tag(0)
            
            warningPage
                .tag(1)
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
    
    private var welcomePage: some View {
        VStack(spacing: 20) {
            Image(systemName: "newspaper.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            
            Text("Welcome to Reader Chan")
                .font(.title)
                .bold()
            
            Text("Browse 4chan boards and threads in a clean, modern interface")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Next") {
                withAnimation {
                    currentPage = 1
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)
        }
        .padding()
    }
    
    private var warningPage: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.yellow)
            
            Text("Content Warning")
                .font(.title)
                .bold()
            
            Text("This app provides access to 4chan content which may include mature themes. By continuing, you confirm that you are of legal age and accept responsibility for the content you view.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("I Understand & Accept") {
                UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                hasCompletedOnboarding = true
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)
        }
        .padding()
    }
}
