import RxCocoa
import UIKit

enum SearchNavigationOption {
}

protocol SearchWireframeInterface {
    func navigate(to option: SearchNavigationOption)
}

protocol SearchPresenterInterface {
    var viewModelDriver: Driver<SearchViewModel> { get }

    func didTextChangeSearchBar(query: String)
}

protocol SearchInteractorInterface {
    var searchModelDriver: Driver<[RepositoryModel]> { get }

    func getRepositories(query: String)
}
