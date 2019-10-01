import SimpleDataSource

struct SearchViewModel {

    var cellViewModels: [AnyDequeuableTableViewCellViewModel]

    init(cellNetworkModels: [RepositoryModel]) {
        cellViewModels = cellNetworkModels.map { repositoryModel in
            RepositoryTableViewCellViewModel(
                imageUrl: repositoryModel.owner.avatarURL,
                title: repositoryModel.name,
                ownerName: repositoryModel.owner.name,
                forksCount: repositoryModel.forks,
                watchersCount: repositoryModel.watchers,
                issuesCount: repositoryModel.issues,
                didTapCell: nil).tableViewPresentable
            }
    }
}
