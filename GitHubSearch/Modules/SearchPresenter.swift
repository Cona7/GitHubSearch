import RxSwift
import RxCocoa
import UIKit

final class SearchPresenter {
    private let interactor: SearchInteractorInterface
    private let wireframe: SearchWireframeInterface

    init(wireframe: SearchWireframeInterface,
         interactor: SearchInteractorInterface) {
        self.wireframe = wireframe
        self.interactor = interactor
    }
}

extension SearchPresenter: SearchPresenterInterface {
    var viewModelDriver: Driver<SearchViewModel> {
        return interactor.searchModelDriver.map {
            return SearchViewModel(cellNetworkModels: $0)
        }
    }

    func didTextChangeSearchBar(query: String) {
        if query != "" {
            interactor.getRepositories(query: query)
        }
    }
}
