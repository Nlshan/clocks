// TimerView.swift
import SwiftUI
import LocalAuthentication

struct TimerView: View {
    var onUnlock: () -> Void

    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    @State private var seconds: Int = 0

    @State private var isRunning = false
    @State private var timeRemaining = 0
    @State private var timer: Timer?

    // 1m 40s is the secret password
    private let secretHours = 0
    private let secretMinutes = 1
    private let secretSeconds = 40

    var body: some View {
        VStack {
            Spacer()

            if isRunning {
                // Fake Running Timer View
                ZStack {
                    Circle()
                        .stroke(lineWidth: 10)
                        .opacity(0.3)
                        .foregroundColor(.gray)

                    Circle()
                        .trim(from: 0.0, to: 1.0)
                        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .foregroundColor(.orange)
                        .rotationEffect(Angle(degrees: 270.0))

                    Text(timeString(time: timeRemaining))
                        .font(.system(size: 60, weight: .light, design: .monospaced))
                }
                .padding(40)
            } else {
                // Time Picker View
                HStack(spacing: 0) {
                    Picker("Hours", selection: $hours) {
                        ForEach(0..<24) { Text("\($0) hours").tag($0) }
                    }
                    .pickerStyle(WheelPickerStyle())

                    Picker("Minutes", selection: $minutes) {
                        ForEach(0..<60) { Text("\($0) min").tag($0) }
                    }
                    .pickerStyle(WheelPickerStyle())

                    Picker("Seconds", selection: $seconds) {
                        ForEach(0..<60) { Text("\($0) sec").tag($0) }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                .frame(height: 250)
            }

            Spacer()

            HStack {
                Button(action: {
                    cancelTimer()
                }) {
                    Text("Cancel")
                        .font(.title3)
                        .frame(width: 80, height: 80)
                        .background(Color.gray.opacity(0.3))
                        .foregroundColor(.gray)
                        .clipShape(Circle())
                }

                Spacer()

                Button(action: {
                    handleStartTapped()
                }) {
                    Text(isRunning ? "Pause" : "Start")
                        .font(.title3)
                        .frame(width: 80, height: 80)
                        .background(Color.orange.opacity(0.3))
                        .foregroundColor(.orange)
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 60)
        }
        .background(Color.black.ignoresSafeArea())
    }

    private func handleStartTapped() {
        if !isRunning {
            if hours == secretHours && minutes == secretMinutes && seconds == secretSeconds {
                authenticateAndUnlock()
            } else {
                startFakeTimer()
            }
        }
    }

    private func authenticateAndUnlock() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Unlock Timer") { success, _ in
                DispatchQueue.main.async {
                    if success {
                        onUnlock()
                    } else {
                        startFakeTimer() // If they fail, just act like a normal timer
                    }
                }
            }
        } else {
            // Fallback if no FaceID - just unlock
            onUnlock()
        }
    }

    private func startFakeTimer() {
        if hours == 0 && minutes == 0 && seconds == 0 { return }
        timeRemaining = (hours * 3600) + (minutes * 60) + seconds
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                cancelTimer()
            }
        }
    }

    private func cancelTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }

    private func timeString(time: Int) -> String {
        let h = time / 3600
        let m = (time % 3600) / 60
        let s = time % 60
        if h > 0 {
            return String(format: "%02d:%02d:%02d", h, m, s)
        }
        return String(format: "%02d:%02d", m, s)
    }
}
