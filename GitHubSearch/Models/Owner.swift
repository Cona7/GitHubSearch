import Foundation

struct Owner: Codable {
    let name: String
    let avatarURL: URL

    let ownerUrl: URL

    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatarURL = "avatar_url"

        case ownerUrl = "html_url"
    }
}
