struct SearchModel {
    var users: [Owner] = []
    var repositories: [Repository] = []

    var state: SearchType = .repositories

    var searchLabel: String = "Search GitHub"

    var shouldClearQuery: Bool = false
}
