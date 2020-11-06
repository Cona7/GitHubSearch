import SimpleDataSource

struct SearchViewModel {
    let rightBarButton: BarButtonItem

    let searchPlaceholder: String
    let searchLabel: String

    let shouldClearQuery: Bool

    var cellViewModels: [AnyDequeuableTableViewCellViewModel]

    init(model: SearchModel, delegate: SearchViewModelDelegate) {
        self.rightBarButton = BarButtonItem.create(image: #imageLiteral(resourceName: "filter"), withTapCallback: { [weak delegate] in delegate?.didTapFilter() })

        self.searchPlaceholder = model.state.placeholder
        self.searchLabel = model.searchLabel

        self.shouldClearQuery = model.shouldClearQuery
        cellViewModels = shouldClearQuery
            ? []
            : model.searchListModel.map { searchListModel in
                RepositoryTableViewCellViewModel(
                    imageUrl: searchListModel.avatarURL,
                    title: searchListModel.title,
                    ownerName: searchListModel.username,
                    info: searchListModel.details,
                    didTapCell: { delegate.didTapCell(model: searchListModel, state: model.state) },
                    didTapImage: { delegate.didTapCellAvatarImage(model: searchListModel, state: model.state) }).tableViewPresentable
        }
    }
}
