import RxCocoa
import UIKit

enum SearchNavigationOption {
    case filter
}

protocol SearchWireframeInterface {
    func navigate(to option: SearchNavigationOption, delegate: SearchFilterDelegate)
}

protocol SearchPresenterInterface {
    var viewModelDriver: Driver<SearchViewModel> { get }

    func didTextChangeSearchBar(query: String)
}

protocol SearchInteractorInterface {
    var searchModelDriver: Driver<[RepositoryModel]> { get }

    func getEntities(query: String)
    func getEntities()
}

protocol SearchViewModelDelegate: class {
    func didTapFilter()

    func didTapRepository(model: RepositoryModel)
    func didTapCellAvatarImage(model: RepositoryModel)
}

protocol SearchFilterDelegate: class {
    func didSaveFilterParameters()
}
