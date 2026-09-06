import SwiftUI

struct ContentView: View {
    @State private var isVaultUnlocked = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if isVaultUnlocked {
                InstagramContainerView()
                    .transition(.opacity)
            } else {
                MainClockView(onUnlock: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isVaultUnlocked = true
                    }
                })
            }
        }
        .preferredColorScheme(.dark)
    }
}
