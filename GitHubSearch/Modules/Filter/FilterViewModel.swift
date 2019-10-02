import SimpleDataSource

struct FilterViewModel {
    let rightBarButton: BarButtonItem

    var cellViewModels: [AnyDequeuableTableViewCellViewModel]

    init(delegate: FilterViewModelDelegate, filterParameters: FilterParameters) {
        self.rightBarButton = BarButtonItem.create(title: "Save", withTapCallback: { [weak delegate] in
            delegate?.didTapSave() })

        cellViewModels = [
            FilterTableViewCellViewModel(
                name: "Search by",
                segmentedControlItems: [SearchType.repositories.title, SearchType.users.title],
                selectedSegmentedIndex: filterParameters.searchBy.rawValue,
                filterType: .search,
                didChangeValue: { [weak delegate] index, filterType in
                    delegate?.didChangeValue(index: index, filterType: filterType) }
            ).tableViewPresentable,
            FilterTableViewCellViewModel(
                name: "Sort by",
                segmentedControlItems: [SortType.stars.title, SortType.forks.title, SortType.updated.title],
                selectedSegmentedIndex: filterParameters.sortBy.rawValue,
                filterType: .sort,
                didChangeValue: { [weak delegate] index, filterType in
                    delegate?.didChangeValue(index: index, filterType: filterType)  }
            ).tableViewPresentable
        ]
    }
}
