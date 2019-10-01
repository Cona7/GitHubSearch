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
        return .just(SearchViewModel())
    }
}
