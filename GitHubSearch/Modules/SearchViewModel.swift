import SimpleDataSource

struct SearchViewModel {

    var cellViewModels: [AnyDequeuableTableViewCellViewModel]

    init() {
        // TODO remove mock values
        cellViewModels = [
            RepoCellViewModel(imageUrl: nil, title: "RepoTest", ownerName: "TestUser", forksCount: 23, watchersCount: 12, issuesCount: 34, didTapCell: nil),
            RepoCellViewModel(imageUrl: nil, title: "RepoTest1", ownerName: "TestUser1", forksCount: 2, watchersCount: 123, issuesCount: 334, didTapCell: nil),
            RepoCellViewModel(imageUrl: nil, title: "RepoTest13", ownerName: "TestUser12", forksCount: 23, watchersCount: 1, issuesCount: 54, didTapCell: nil)
            ].map { $0.tableViewPresentable }
    }
}
