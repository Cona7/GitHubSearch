import RxCocoa
import UIKit

enum SearchNavigationOption {
}

protocol SearchWireframeInterface {
    func navigate(to option: SearchNavigationOption)
}

protocol SearchPresenterInterface {
    var viewModelDriver: Driver<SearchViewModel> { get }
}

protocol SearchInteractorInterface {
}
