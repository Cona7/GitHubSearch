import Foundation

struct RepositoryNetworkModel: Codable {
    let name: String
    let owner: OwnerNetworkModel
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
