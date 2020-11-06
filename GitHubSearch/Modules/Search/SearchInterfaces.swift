import RxCocoa
import UIKit

enum SearchNavigationOption {
    case filter(delegate: SearchFilterDelegate)
    case repoDetails(name: String, username: String)
    case userDetails(name: String, avatarURL: URL?)
}

protocol SearchWireframeInterface: WireframeInterface {
    func navigate(to option: SearchNavigationOption)
}

protocol SearchPresenterInterface {
    var viewModelDriver: Driver<SearchViewModel> { get }

    func didTextChangeSearchBar(query: String)
}

protocol SearchInteractorInterface {
    var searchModelDriver: Driver<SearchModel> { get }
    var errorDriver: Driver<Error> { get }

    func getEntities(query: String)
    func getEntities()
}

protocol SearchViewModelDelegate: class {
    func didTapFilter()

    func didTapCell(model: SearchListModel, state: SearchType)
    func didTapCellAvatarImage(model: SearchListModel, state: SearchType)
}

protocol SearchFilterDelegate: class {
    func didSaveFilterParameters()
}
