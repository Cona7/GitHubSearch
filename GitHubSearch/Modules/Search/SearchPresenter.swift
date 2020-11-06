import RxSwift
import RxCocoa
import UIKit

final class SearchPresenter {
    private let interactor: SearchInteractorInterface
    private let wireframe: SearchWireframeInterface

    private let disposeBag = DisposeBag()

    private var lastSearchQueryUpdateDate: Date?

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
        let currentDate = Date()
        self.lastSearchQueryUpdateDate = currentDate

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if currentDate == self.lastSearchQueryUpdateDate {
                self.interactor.getEntities(query: query)
            }
        }
    }
}

extension SearchPresenter: SearchViewModelDelegate {
    func didTapFilter() {
        wireframe.navigate(to: .filter(delegate: self))
    }

    func didTapCell(model: SearchListModel, state: SearchType) {
        switch state {
        case .repositories:
            wireframe.navigate(to: .repoDetails(name: model.title, username: model.username))
        case .users:
            wireframe.navigate(to: .userDetails(name: model.username, avatarURL: model.avatarURL))
        }
    }

    func didTapCellAvatarImage(model: SearchListModel, state: SearchType) {
        switch state {
        case .repositories:
            wireframe.navigate(to: .userDetails(name: model.username, avatarURL: model.avatarURL))
        case .users:
            return
        }
    }
}

extension SearchPresenter: SearchFilterDelegate {
    func didSaveFilterParameters() {
        interactor.getEntities()
    }
}
