import Foundation
import RxSwift
import RxRelay
import RxCocoa

final class SearchInteractor {
    private var searchModelVariable = BehaviorRelay(value: [RepositoryModel]())

    private var query: String = ""

    private let disposeBag = DisposeBag()
}
extension SearchInteractor: SearchInteractorInterface {
    var searchModelDriver: Driver<[RepositoryModel]> {
        return searchModelVariable.asDriver()
    }

    func getEntities() {
        getEntities(query: self.query)
    }

    func getEntities(query: String) {
        self.query = query

        let filterParameters = FilterParametersDataSource.shared.filterParameters

        if filterParameters.searchBy == .repositories {
            SearchNetworkManager
                .getRepositories(query: query, sort: filterParameters.sortBy.query)
                .subscribe { [unowned self] respone in
                    switch respone {
                    case .success(let value):
                        self.searchModelVariable.accept(value.items)
                    case .error(let error):
                        print(error)
                    }
            }.disposed(by: disposeBag)
        }
    }
}
