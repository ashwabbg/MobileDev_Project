import SwiftUI

struct EventDetailView: View {
    var event: Event
    
    private func eventImage(for eventType: String) -> some View {
        let imageName: String

        switch eventType {
            case "Meal":
                imageName = "meal"
            case "Networking":
                imageName = "networking"
            case "Keynote":
                imageName = "keynote"
            case "Panel":
                imageName = "panel"
            case "Workshop":
                imageName = "workshop"
            case "Breakout session":
                imageName = "breakout-session"
            default:
                imageName = "default-image"
        }

        return Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 150)
            .clipped()
            .padding(.horizontal, 4)
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            eventImage(for: event.fields.type)
            
            Text(event.fields.activity)
                .font(.title)
                .bold()
            
            HStack {
                Text("\(Date.fromISOString(event.fields.start))")
                    .frame(width: 100)
                Text("to")
                Text("\(Date.fromISOString(event.fields.end))")
                    .frame(width: 100)
            }
            .foregroundColor(.gray)
            
            VStack {
                HStack {
                    Image(systemName: "map")
                    Text("Location").bold()
                }
                Text("\(event.fields.location)")
            }
            
            if let notes = event.fields.notes {
                VStack {
                    HStack {
                        Image(systemName: "doc.text")
                        Text("Notes").bold()
                    }
                    Text(notes)
                        .multilineTextAlignment(.center)
                }
            }
            
            if let speakers = event.fields.speakers {
                VStack {
                    HStack {
                        Image(systemName: "person.2")
                        Text("Speakers").bold()
                    }
                    Text(speakers.joined(separator: ", "))
                }
            }
            
            
            
//            if let speakers = event.fields.speakers {
//                Text("Notes: \(speakers)")
//                    .padding()
//            }
        }
        .padding()
        .navigationTitle("Event Details")
    }
}
