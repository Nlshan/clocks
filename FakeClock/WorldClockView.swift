import SwiftUI

struct WorldClockCity: Identifiable {
    let id = UUID()
    let name: String
    let offset: String
    let time: String
    let period: String
}

struct WorldClockView: View {
    let cities: [WorldClockCity] = [
        WorldClockCity(name: "Cupertino", offset: "Today, -3HRS", time: "6:41", period: "AM"),
        WorldClockCity(name: "New York", offset: "Today, +0HRS", time: "9:41", period: "AM"),
        WorldClockCity(name: "London", offset: "Today, +5HRS", time: "2:41", period: "PM")
    ]

    var body: some View {
        NavigationStack {
            List {
                ForEach(cities) { city in
                    HStack(alignment: .lastTextBaseline) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(city.offset).font(.caption).foregroundColor(.gray)
                            Text(city.name).font(.title2).fontWeight(.medium).foregroundColor(.white)
                        }
                        Spacer()
                        HStack(alignment: .firstTextBaseline, spacing: 2) {
                            Text(city.time).font(.system(size: 48, weight: .light)).foregroundColor(.white)
                            Text(city.period).font(.title3).foregroundColor(.white)
                        }
                    }
                    .padding(.vertical, 8)
                    .listRowBackground(Color.black)
                }
            }
            .listStyle(.plain)
            .background(Color.black)
            .navigationTitle("World Clock")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { Button("Edit") {}.foregroundColor(.orange) }
                ToolbarItem(placement: .topBarTrailing) { Button(action: {}) { Image(systemName: "plus").foregroundColor(.orange) } }
            }
        }
    }
}
