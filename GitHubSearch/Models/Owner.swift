import Foundation

struct Owner: Codable {
    let name: String
    let avatarURL: URL
    let ownerUrl: URL
    let type: String
    let score: Double?
    
    var details: String {
        guard let score = score else {
            return ""
        }

        return "Score: \(String(score))"
    }

    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatarURL = "avatar_url"
        case ownerUrl = "html_url"
        case type
        case score
    }
}
