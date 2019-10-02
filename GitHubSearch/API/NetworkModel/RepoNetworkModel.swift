import Foundation

struct RepositoryNetworkModel: Codable {
    let totalCount: Int
    let isResultIncomplete: Bool
    let items: [RepositoryModel]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case isResultIncomplete = "incomplete_results"
        case items
    }
}

struct RepositoryModel: Codable {
    let name: String
    let owner: Owner
    let forks: Int
    let watchers: Int
    let issues: Int

    enum CodingKeys: String, CodingKey {
        case name
        case owner
        case forks
        case watchers
        case issues = "open_issues_count"
    }
}

struct Owner: Codable {
    let name: String
    let avatarURL: URL

    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatarURL = "avatar_url"
    }
}
