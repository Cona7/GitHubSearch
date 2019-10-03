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
