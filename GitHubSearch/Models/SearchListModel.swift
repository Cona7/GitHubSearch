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
            details: "forks: \(String(model.forks)), watchers: \(String(model.watchers)), issues: \(String(model.issues))")
    }

    static func from(model: Owner) -> SearchListModel {
        return SearchListModel(
            title: model.type,
            avatarURL: model.avatarURL,
            username: model.name,
            details: "Score: \(String(model.score!))")
    }
}
