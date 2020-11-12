import Foundation

protocol SearchListModel: Codable {
    var title: String { get }
    var imageURL: URL? { get }
    var username: String { get }
    var details: String { get }
}
