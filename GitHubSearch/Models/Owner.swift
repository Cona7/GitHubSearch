import Foundation

struct Owner: Codable {
    let name: String
    let avatarURL: URL
    let ownerUrl: URL
    let type: String
    let score: Double?

    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatarURL = "avatar_url"
        case ownerUrl = "html_url"
        case type
        case score
    }
}
