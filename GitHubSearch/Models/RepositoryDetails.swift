import Foundation

struct RepositoryDetails: Codable {
    let name: String
    let owner: Owner
    let forks: Int
    let watchers: Int
    let issues: Int

    let description: String?
    let created: String?
    let updated: String?
    let language: String?

    let repoURL: URL?

    enum CodingKeys: String, CodingKey {
        case name
        case owner
        case forks
        case watchers
        case issues = "open_issues_count"

        case description
        case created = "created_at"
        case updated = "updated_at"
        case language

        case repoURL = "html_url"
    }

    static func from(model: Repository) -> RepositoryDetails {
        return RepositoryDetails(
            name: model.name,
            owner: model.owner,
            forks: model.forks,
            watchers: model.watchers,
            issues: model.forks,
            description: nil,
            created: nil,
            updated: nil,
            language: nil,
            repoURL: nil
        )
    }
}
