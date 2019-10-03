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
            return SearchViewModel(cellNetworkModels: $0, delegate: self)
        }
    }

    func didTextChangeSearchBar(query: String) {
        if query != "" {
            interactor.getEntities(query: query)
        }
    }
}

extension SearchPresenter: SearchViewModelDelegate {
    func didTapFilter() {
        wireframe.navigate(to: .filter(delegate: self))
    }

    func didTapRepository(model: Repository) {
        wireframe.navigate(to: .repoDetails(repositoryModel: model))
    }

    func didTapCellAvatarImage(model: Repository) {
        wireframe.navigate(to: .userDetails(owner: model.owner))
      }
}

extension SearchPresenter: SearchFilterDelegate {
    func didSaveFilterParameters() {
        interactor.getEntities()
    }
}
