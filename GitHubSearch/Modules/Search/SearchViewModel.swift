import SimpleDataSource

struct SearchViewModel {

    let rightBarButton: BarButtonItem

    let searchPlaceholder: String
    let searchLabel: String

    let shouldClearQuery: Bool

    var cellViewModels: [AnyDequeuableTableViewCellViewModel]

    var state: SearchType

    init(model: SearchModel, delegate: SearchViewModelDelegate) {
        self.rightBarButton = BarButtonItem.create(image: #imageLiteral(resourceName: "filter"), withTapCallback: { [weak delegate] in
            delegate?.didTapFilter() })

        self.searchPlaceholder = model.state.placeholder
        self.searchLabel = model.searchLabel

        self.shouldClearQuery = model.shouldClearQuery

        if shouldClearQuery {
            cellViewModels = []
        } else {
            switch model.state {
            case .repositories:
                self.cellViewModels = model.repositories.map { repositoryModel in
                    RepositoryTableViewCellViewModel(
                        imageUrl: repositoryModel.owner.avatarURL,
                        title: repositoryModel.name,
                        ownerName: repositoryModel.owner.name,
                        info: "forks: \(String(repositoryModel.forks)), watchers: \(String(repositoryModel.watchers)), issues: \(String(repositoryModel.issues))",
                        didTapCell: { delegate.didTapRepository(model: repositoryModel) },
                        didTapImage: { delegate.didTapCellAvatarImage(model: repositoryModel) }).tableViewPresentable
                }
            case .users:
                self.cellViewModels = model.users.map { userModel in
                    RepositoryTableViewCellViewModel(
                        imageUrl: userModel.avatarURL,
                        title: userModel.type,
                        ownerName: userModel.name,
                        info: "Score: \(String(userModel.score!))",
                        didTapCell: { delegate.didTapUser(model: userModel) },
                        didTapImage: {}).tableViewPresentable
                }
            }
        }

        self.state = model.state
    }
}
