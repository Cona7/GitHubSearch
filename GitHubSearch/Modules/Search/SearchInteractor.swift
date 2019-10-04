import Foundation
import RxSwift
import RxRelay
import RxCocoa

final class SearchInteractor {
    private var searchModel = BehaviorRelay(value: SearchModel())
    private let errorSubject = PublishSubject<Error>()

    private var query: String = ""

    private let disposeBag = DisposeBag()
}
extension SearchInteractor: SearchInteractorInterface {
    var searchModelDriver: Driver<SearchModel> {
        return searchModel.asDriver()
    }

    var errorDriver: Driver<Error> {
        return errorSubject
            .asDriver {
                return Driver.just($0)
        }
    }

    func getEntities() {
        getEntities(query: self.query)
    }

    func getEntities(query: String) {
        self.query = query

        let filterParameters = FilterParametersDataSource.shared.filterParameters

        let shouldClearQuery = filterParameters.searchBy != searchModel.value.state

        guard !shouldClearQuery else {
            return searchModel.accept(
                SearchModel(
                    users: self.searchModel.value.users,
                    repositories: self.searchModel.value.repositories,
                    state: filterParameters.searchBy,
                    searchLabel: searchModel.value.searchLabel,
                    shouldClearQuery: shouldClearQuery)
            )
        }

        if query == "" {
            return
        }

        if filterParameters.searchBy == .repositories {
            SearchNetworkManager
                .getRepositories(query: query, sort: filterParameters.sortBy.query)
                .subscribe { [unowned self] respone in
                    switch respone {
                    case .success(let value):
                        self.searchModel.accept(SearchModel(users: self.searchModel.value.users, repositories: value.items, state: filterParameters.searchBy, shouldClearQuery: shouldClearQuery))
                    case .error(let error):
                        self.errorSubject.onNext(error)
                    }
            }.disposed(by: disposeBag)
        } else {
            SearchNetworkManager
                .getUsers(query: query)
                .subscribe { [unowned self] respone in
                    switch respone {
                    case .success(let value):
                        self.searchModel.accept(
                            SearchModel(users: value.items,
                                        repositories: self.searchModel.value.repositories,
                                        state: filterParameters.searchBy,
                                        shouldClearQuery: shouldClearQuery)
                        )
                    case .error(let error):
                        self.errorSubject.onNext(error)
                    }
            }.disposed(by: disposeBag)
        }
    }
}
