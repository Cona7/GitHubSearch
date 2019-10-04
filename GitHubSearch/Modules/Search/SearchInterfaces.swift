import RxCocoa
import UIKit

enum SearchNavigationOption {
    case filter(delegate: SearchFilterDelegate)
    case repoDetails(repositoryModel: Repository)
    case userDetails(owner: Owner)
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

    func didTapRepository(model: Repository)
    func didTapCellAvatarImage(model: Repository)

    func didTapUser(model: Owner)
}

protocol SearchFilterDelegate: class {
    func didSaveFilterParameters()
}
