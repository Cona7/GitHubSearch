import Foundation

struct UserDetails: Codable {
    let login: String
    let avatarURL: URL

    let ownerUrl: URL

    let type: String
    let name: String?

    let followers: Int

    enum CodingKeys: String, CodingKey {
        case login = "login"
        case avatarURL = "avatar_url"
        case ownerUrl = "html_url"
        case type
        case name
        case followers
    }
}
