import RxSwift
import RxCocoa
import UIKit

final class SearchPresenter {
    private let interactor: SearchInteractorInterface
    private let wireframe: SearchWireframeInterface

    private let disposeBag = DisposeBag()

    init(wireframe: SearchWireframeInterface,
         interactor: SearchInteractorInterface) {
        self.wireframe = wireframe
        self.interactor = interactor

        interactor
               .errorDriver
               .drive(
                   onNext: { [unowned self] error in
                       self.wireframe.present(error: error)
                   }
               ).disposed(by: disposeBag)

    }
}

extension SearchPresenter: SearchPresenterInterface {
    var viewModelDriver: Driver<SearchViewModel> {
        return interactor.searchModelDriver.map {
            return SearchViewModel(model: $0, delegate: self)
        }
    }

    func didTextChangeSearchBar(query: String) {
        interactor.getEntities(query: query)
    }
}

extension SearchPresenter: SearchViewModelDelegate {
    func didTapFilter() {
        wireframe.navigate(to: .filter(delegate: self))
    }

    func didTapRepository(model: Repository) {
        wireframe.navigate(to: .repoDetails(repositoryModel: model))
    }

    func didTapUser(model: Owner) {
         wireframe.navigate(to: .userDetails(owner: model))
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
