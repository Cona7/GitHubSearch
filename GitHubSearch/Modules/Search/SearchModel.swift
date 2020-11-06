struct SearchModel {
    var searchListModel: [SearchListModel] = []

    var state: SearchType = .repositories

    var searchLabel: String = "Search GitHub"

    var shouldClearQuery: Bool = false
}
