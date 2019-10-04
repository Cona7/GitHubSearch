import Foundation

struct UserListNetworkModel: Codable {
    let totalCount: Int
    let isResultIncomplete: Bool
    let items: [Owner]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case isResultIncomplete = "incomplete_results"
        case items
    }
}
