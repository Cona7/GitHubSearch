class FilterParametersDataSource {

    static var shared = FilterParametersDataSource()

    private var searchBy: SearchType
    private var sortBy: SortType

    // TODO add UserDefaults
    init() {
        // default filter parameters
        searchBy = .repositories
        sortBy = .stars
    }

    func setSearchValue(search: SearchType) {
        self.searchBy = search
    }

    func setSortValue(sort: SortType) {
          self.sortBy = sort
      }

    var filterParameters: FilterParameters {
        return FilterParameters(searchBy: searchBy, sortBy: sortBy)
    }
}
