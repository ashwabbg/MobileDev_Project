import SwiftUI

struct HomeView: View {
    @State private var events: [Event] = []
    
    // Get today conferences
    private func eventsForToday() -> [Event]? {
        let today = Date()
        return events.filter { event in
            return Calendar.current.isDate(Date.fromString2Date(event.fields.start), inSameDayAs: today)
        }
    }
    
    // Get upcoming conferences
    private func upcomingEvents() -> [Event] {
        let today = Date()
        return events.filter { Date.fromString2Date($0.fields.start) > today }
    }
 
    var body: some View {
        NavigationView {
            VStack {
                Text("Conference Schedule")
                    .font(.largeTitle)
                    .padding()
                
                // Show today conferences
                Section(header: Text("Today")) {
                    if let todayEvents = eventsForToday(), !todayEvents.isEmpty {
                        EventListView(events: todayEvents)
                    } else {
                        Text("No events scheduled today.")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                
                // Show upcoming conferences
                Section(header: Text("Upcoming events")) {
                    EventListView(events: upcomingEvents())
                }
            }
            .onAppear {
                // Fetch events when the view appears
                RequestFactory.shared.getFurnitureList { fetchedEvents, error in
                    if let fetchedEvents = fetchedEvents {
                        events = fetchedEvents
                    } else {
                        // Handle errors
                    }
                }
            }
        }
    }
}
