import Foundation
import RxSwift
import RxRelay
import RxCocoa

final class SearchInteractor {
    private var searchModelVariable = BehaviorRelay(value: [RepositoryModel]())

    private let disposeBag = DisposeBag()
}
extension SearchInteractor: SearchInteractorInterface {
    var searchModelDriver: Driver<[RepositoryModel]> {
        return searchModelVariable.asDriver()
    }

    func getRepositories(query: String) {
        SearchNetworkManager
            .getRepositories(query: query)
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
