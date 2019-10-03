import SimpleDataSource

struct FilterViewModel {
    let rightBarButton: BarButtonItem

    var cellViewModels: [AnyDequeuableTableViewCellViewModel]

    init(delegate: FilterViewModelDelegate, filterParameters: FilterParameters) {
        self.rightBarButton = BarButtonItem.create(title: "Save", withTapCallback: { [weak delegate] in
            delegate?.didTapSave() })

        cellViewModels = [
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
