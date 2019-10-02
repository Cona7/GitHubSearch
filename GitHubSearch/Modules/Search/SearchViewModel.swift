import SimpleDataSource

struct SearchViewModel {

    let rightBarButton: BarButtonItem

    var cellViewModels: [AnyDequeuableTableViewCellViewModel]

    init(cellNetworkModels: [RepositoryModel], delegate: SearchViewModelDelegate) {
        self.rightBarButton = BarButtonItem.create(image: #imageLiteral(resourceName: "filter"), withTapCallback: { [weak delegate] in
            delegate?.didTapFilter() })

        self.cellViewModels = cellNetworkModels.map { repositoryModel in
            RepositoryTableViewCellViewModel(
                imageUrl: repositoryModel.owner.avatarURL,
                title: repositoryModel.name,
                ownerName: repositoryModel.owner.name,
                forksCount: repositoryModel.forks,
                watchersCount: repositoryModel.watchers,
                issuesCount: repositoryModel.issues,
                didTapCell: { delegate.didTapRepository(model: repositoryModel) },
                didTapImage: { delegate.didTapCellAvatarImage(model: repositoryModel) }).tableViewPresentable
        }
    }
}
