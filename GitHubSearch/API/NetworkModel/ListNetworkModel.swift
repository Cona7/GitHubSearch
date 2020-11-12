import Foundation

struct ListNetworkModel<T: Codable>: Codable {
    let totalCount: Int
    let isResultIncomplete: Bool
    let items: [T]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case isResultIncomplete = "incomplete_results"
        case items
    }
}
