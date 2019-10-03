import RxSwift
import Foundation

class SearchNetworkManager {
    struct Query: Encodable {
        let query: String
        let sort: String

        // swiftlint:disable nesting
        private enum CodingKeys: String, CodingKey {
            case query = "q"
            case sort
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

    static func getRepositories(query: String, sort: String) -> Single<RepositoryNetworkModel> {
        do {
            let parameters = try self.encode(Query(query: query, sort: sort))

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

    static func getRepositoryDetails(repoName: String, owner: String) -> Single<RepositoryDetails> {
        return NetworkManager
            .performRequest(
                url: ApplicationManager.shared.host + "/repos/\(owner)/\(repoName)"
        )
    }

    static func getUserDetails(owner: Owner) -> Single<UserDetails> {
        return NetworkManager
            .performRequest(
                url: ApplicationManager.shared.host + "/users/\(owner.name)"
        )
    }
}
