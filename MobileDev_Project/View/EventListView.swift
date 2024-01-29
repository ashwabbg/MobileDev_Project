import SwiftUI

// Event list component
struct EventListView: View {
    var events: [Event]
    
    var body: some View {
        List(events) { event in
            NavigationLink(destination: EventDetailView(event: event)) {
                VStack(alignment: .leading) {
                    Text(event.fields.activity)
                    Text("\(Date.fromISOString(event.fields.start)) - \(Date.fromISOString(event.fields.end))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}
