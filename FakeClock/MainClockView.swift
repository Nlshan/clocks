import SwiftUI

struct MainClockView: View {
    var onUnlock: () -> Void
    @State private var selectedTab = 3

    init(onUnlock: @escaping () -> Void) {
        self.onUnlock = onUnlock
        // iOS Tab Bar styling
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.85)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            WorldClockView()
                .tabItem { Label("World Clock", systemImage: "globe") }
                .tag(0)

            AlarmsView()
                .tabItem { Label("Alarm", systemImage: "alarm.fill") }
                .tag(1)

            StopwatchView()
                .tabItem { Label("Stopwatch", systemImage: "stopwatch.fill") }
                .tag(2)

            TimerView(onUnlock: onUnlock)
                .tabItem { Label("Timer", systemImage: "timer") }
                .tag(3)
        }
        .accentColor(.orange)
    }
}
