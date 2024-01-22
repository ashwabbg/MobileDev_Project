import SwiftUI

struct DayDetailView: View {
    var event: Event

    var body: some View {
        VStack {
            Text(event.fields.activity)
                .font(.title)
            Text("\(Date.fromISOString(event.fields.start)) - \(Date.fromISOString(event.fields.end))")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("Location: \(event.fields.location)")
            Text("Type: \(event.fields.type)")
             // Add more details based on your needs
            if let notes = event.fields.notes {
                Text("Notes: \(notes)")
                    .padding()
            }
        }
        .navigationTitle("Conference Schedule") // Use navigationTitle for iOS
    }
}


