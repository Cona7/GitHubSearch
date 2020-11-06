import Foundation

enum DetailsState {
    case repository(name: String, username: String)
    case user(name: String, avatarURL: URL?)
}
