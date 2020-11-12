import Foundation

struct SearchListModel {
    var title: String
    var avatarURL: URL?
    var username: String
    var details: String

    static func from(model: Repository) -> SearchListModel {
        return SearchListModel(
            title: model.name,
            avatarURL: model.owner.avatarURL,
            username: model.owner.name,
            details: getRepoDetails(forks: model.forks, watchers: model.watchers, issues: model.issues)
        )
    }

    static func from(model: Owner) -> SearchListModel {
        return SearchListModel(
            title: model.type,
            avatarURL: model.avatarURL,
            username: model.name,
            details: getUserDetails(score: model.score))
    }

    static func getRepoDetails(forks: Int, watchers: Int, issues: Int) -> String {
        return "forks: \(String(forks)), watchers: \(String(watchers)), issues: \(String(issues))"
    }

    static func getUserDetails(score: Double?) -> String {
        if let score = score {
            return "Score: \(String(score))"
        } else {
            return ""
        }
    }
}
