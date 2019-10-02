enum SearchType: Int {
    case repositories
    case users

    var title: String {
        switch self {
        case .repositories:
            return "Repositories"
        case .users:
            return "Users"
        }
    }

    var query: String {
        switch self {
        case .repositories:
            return "repositories"
        case .users:
            return "users"
        }
    }
}
