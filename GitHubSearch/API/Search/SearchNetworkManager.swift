import RxSwift
import Foundation

class SearchNetworkManager {
    struct Query: Encodable {
        let query: String

        // swiftlint:disable nesting
        private enum CodingKeys: String, CodingKey {
            case query = "q"
        }
    }

    static func encode<T: Encodable>(_ value: T) throws -> [String: Any] {
        let encoder = JSONEncoder()

        let data = try encoder.encode(value)
        guard let parameter = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw NetworkError.JSONSerialization
        }

        return parameter
    }

    static func getRepositories(query: String) -> Single<RepoNetworkModel> {
        do {
            let parameters = try self.encode(Query(query: query))

            return NetworkManager
                .performRequest(
                    url: ApplicationManager.shared.host + "/search/repositories",
                    method: .get,
                    parameters: parameters
            )
        } catch let error {
            return .error(error)
        }
    }
}
