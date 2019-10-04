import Foundation
import RxSwift
import RxRelay
import RxCocoa

final class SearchInteractor {
    private var searchModel = BehaviorRelay(value: [Repository]())
    private let errorSubject = PublishSubject<Error>()

    private var query: String = ""

    private let disposeBag = DisposeBag()
}
extension SearchInteractor: SearchInteractorInterface {
    var searchModelDriver: Driver<[Repository]> {
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

        if filterParameters.searchBy == .repositories {
            SearchNetworkManager
                .getRepositories(query: query, sort: filterParameters.sortBy.query)
                .subscribe { [unowned self] respone in
                    switch respone {
                    case .success(let value):
                        self.searchModel.accept(value.items)
                    case .error(let error):
                        self.errorSubject.onNext(error)
                    }
            }.disposed(by: disposeBag)
        }
    }
}
