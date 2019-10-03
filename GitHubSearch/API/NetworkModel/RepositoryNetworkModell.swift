import Foundation

struct RepositoryNetworkModel: Codable {
    let totalCount: Int
    let isResultIncomplete: Bool
    let items: [Repository]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case isResultIncomplete = "incomplete_results"
        case items
    }
}
