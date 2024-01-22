import Foundation

struct Fields: Codable {
    var start: String
    let location: String
    let notes: String?
    let activity: String
    var end: String
    let type: String
    let speakers: [String]?
    private enum CodingKeys: String, CodingKey {
        case start = "Start"
        case location = "Location"
        case notes = "Notes"
        case activity = "Activity"
        case end = "End"
        case type = "Type"
        case speakers = "Speaker(s)"
    }
}

enum ActivityType: String, CaseIterable {
    case meal = "Meal"
    case networking = "Networking"
    case keynote = "Keynote"
    case panel = "Panel"
    case workshop = "Workshop"
    case breakoutSession = "Breakout session"
}

extension Date {
    static func fromISOString(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert(.withFractionalSeconds)
        let startDate = formatter.date(from: dateString)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy 'at' h:mm a" // Customize the date format as needed
        return dateFormatter.string(from: startDate!)
    }
}
