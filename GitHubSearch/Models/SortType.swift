enum SortType: Int {
    case stars
    case forks
    case updated

    var title: String {
        switch self {
        case .stars:
            return "Stars"
        case .forks:
            return "Forks"
        case .updated:
            return "Updated"
        }
    }

    var query: String {
        switch self {
        case .stars:
            return "stars"
        case .forks:
            return "forks"
        case .updated:
            return "updated"
        }
    }
}
