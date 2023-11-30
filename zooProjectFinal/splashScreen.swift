import SwiftUI

struct SplashScreen: View {
    @State var showSplash = true
    @State var isActive = false
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea(.all)
            
            if showSplash {
                LogoView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            self.showSplash = false
                            self.isActive = true
                        }
                    }
            } else {
                if isActive {
                    NavigationView {
                        introRegisteration() // Show IntroRegisteration() after splash screen
                    }
                }
            }
        }
    }
}

struct LogoView: View {
    @State private var shouldAnimate = false
    
    var body: some View {
        Image("logo")
            .resizable()
            .frame(width: 200, height: 200)
            .scaleEffect(shouldAnimate ? 1.0 : 0.2) // Scale from 0.2 to 1.0
            .animation(
                Animation.easeInOut(duration: 1.5)
                    .delay(0.5) // Delay the animation
            )
            .onAppear {
                self.shouldAnimate = true
            }
    }
}

// Your IntroRegisteration view here...

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
