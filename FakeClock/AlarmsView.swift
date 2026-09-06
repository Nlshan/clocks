import SwiftUI

struct AlarmItem: Identifiable {
    let id = UUID()
    let time: String
    let period: String
    let label: String
    var isEnabled: Bool
}

struct AlarmsView: View {
    @State private var alarms = [
        AlarmItem(time: "7:00", period: "AM", label: "Alarm, every day", isEnabled: true),
        AlarmItem(time: "8:15", period: "AM", label: "Work", isEnabled: false)
    ]

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Other").foregroundColor(.gray)) {
                    ForEach($alarms) { $alarm in
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                HStack(alignment: .firstTextBaseline, spacing: 2) {
                                    Text(alarm.time).font(.system(size: 48, weight: .light))
                                    Text(alarm.period).font(.title3)
                                }.foregroundColor(alarm.isEnabled ? .white : .gray)
                                Text(alarm.label).font(.caption).foregroundColor(alarm.isEnabled ? .white : .gray)
                            }
                            Spacer()
                            Toggle("", isOn: $alarm.isEnabled).labelsHidden()
                        }
                        .padding(.vertical, 4)
                    }
                }
                .listRowBackground(Color(UIColor.secondarySystemBackground))
            }
            .background(Color.black)
            .navigationTitle("Alarms")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { Button("Edit") {}.foregroundColor(.orange) }
                ToolbarItem(placement: .topBarTrailing) { Button(action: {}) { Image(systemName: "plus").foregroundColor(.orange) } }
            }
        }
    }
}
