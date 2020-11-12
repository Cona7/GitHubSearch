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
        let filterParameters = FilterParametersDataSource.shared.filterParameters
        let shouldClearList = filterParameters.searchBy != searchModel.value.state

        if shouldClearList {
            refreshSearchModel(items: [], state: filterParameters.searchBy, shouldClearQuery: true)
        } else {
            getEntities(query: self.query)
        }
    }

    func getEntities(query: String) {
        self.query = query

        let filterParameters = FilterParametersDataSource.shared.filterParameters
        switch filterParameters.searchBy {
        case .repositories:
            getRepositories(query: query, sortBy: filterParameters.sortBy.query)
        case .users:
            getUsers(query: query)
        }
    }

    func getRepositories(query: String, sortBy: String) {
        SearchNetworkManager
            .getRepositories(query: query, sort: sortBy)
            .subscribe { [unowned self] respone in
                switch respone {
                case .success(let value):
                    self.refreshSearchModel(items: value.items)
                case .error(let error):
                    self.errorSubject.onNext(error)
                }
        }.disposed(by: disposeBag)
    }

    func getUsers(query: String) {
        SearchNetworkManager
            .getUsers(query: query)
            .subscribe { [unowned self] respone in
                switch respone {
                case .success(let value):
                    self.refreshSearchModel(items: value.items)
                case .error(let error):
                    self.errorSubject.onNext(error)
                }
            }.disposed(by: disposeBag)
    }

    func refreshSearchModel(items: [SearchListModel], state: SearchType? = nil, shouldClearQuery: Bool = false) {
        searchModel.accept(
            SearchModel(
                searchListModel: items,
                state: state ?? searchModel.value.state,
                shouldClearQuery: shouldClearQuery))
    }
}
