import Foundation

struct SpeakerFields: Codable {
    let email: String
    let confirmed: Bool?
    let company: String
    let name: String
    let phone: String
    let speakingAt: [String]?
    let role: String
    
    private enum CodingKeys: String, CodingKey {
        case email = "Email"
        case confirmed = "Confirmed?"
        case company = "Company"
        case name = "Name"
        case phone = "Phone"
        case speakingAt = "Speaking at"
        case role = "Role"
    }
}

struct RecordSpeaker: Codable {
    var records: [Speaker]
}

struct Speaker: Codable, Identifiable {
    var id: String
    var createdTime: String
    var fields: SpeakerFields
}

