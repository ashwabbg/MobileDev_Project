import SwiftUI

struct HomeView: View {
    @State private var events: [Event] = []

    var body: some View {
        NavigationView {
            List(events) { event in
                            NavigationLink(destination: DayDetailView(event: event)) {
                                VStack(alignment: .leading) {
                                    Text(event.fields.activity)
                                    Text("\(Date.fromISOString(event.fields.start)) - \(Date.fromISOString(event.fields.end))")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
            .navigationTitle("Conference field") // Use navigationTitle for iOS
            .onAppear {
                // Fetch field when the view appears
                RequestFactory.shared.getFurnitureList { fetchedEvents, Error in
                    if let fetchedEvents = fetchedEvents {
                        events = fetchedEvents
                    } else {
                    }
                }
            }
        }
    }
}
