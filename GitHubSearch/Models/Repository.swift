import Foundation

struct Repository: Codable {
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

extension Repository: SearchListModel {
    var title: String {
        return name
    }

    var imageURL: URL? {
        return owner.avatarURL
    }

    var username: String {
        return owner.name
    }

    var details: String {
        return "forks: \(String(forks)), watchers: \(String(watchers)), issues: \(String(issues))"
    }
}
