import SwiftUI

struct StopwatchView: View {
    @State private var isRunning = false
    @State private var elapsedTime: Double = 0.0
    @State private var timer: Timer?

    var body: some View {
        VStack {
            Spacer()
            Text(formatStopwatchTime(elapsedTime))
                .font(.system(size: 76, weight: .thin, design: .default))
                .monospacedDigit()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
            Spacer()
            HStack {
                Button(action: handleLapOrReset) {
                    Text(isRunning ? "Lap" : "Reset").font(.body).frame(width: 78, height: 78)
                        .background(Color.gray.opacity(0.25)).foregroundColor(.white).clipShape(Circle())
                }
                Spacer()
                Button(action: handleStartOrStop) {
                    Text(isRunning ? "Stop" : "Start").font(.body).frame(width: 78, height: 78)
                        .background(isRunning ? Color.red.opacity(0.25) : Color.green.opacity(0.25))
                        .foregroundColor(isRunning ? .red : .green).clipShape(Circle())
                }
            }
            .padding(.horizontal, 30)
            Spacer()
        }
        .background(Color.black.ignoresSafeArea())
    }

    private func handleStartOrStop() {
        if isRunning {
            timer?.invalidate()
            timer = nil
            isRunning = false
        } else {
            isRunning = true
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in elapsedTime += 0.01 }
        }
    }

    private func handleLapOrReset() {
        if !isRunning { elapsedTime = 0.0 }
    }

    private func formatStopwatchTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let fractions = Int((time.truncatingRemainder(dividingBy: 1)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, fractions)
    }
}
