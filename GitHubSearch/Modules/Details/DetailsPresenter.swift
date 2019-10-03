import RxSwift
import RxCocoa
import UIKit

final class DetailsPresenter {
    private let interactor: DetailsInteractorInterface
    private let wireframe: DetailsWireframeInterface

    init(wireframe: DetailsWireframeInterface,
         interactor: DetailsInteractorInterface) {
        self.wireframe = wireframe
        self.interactor = interactor
    }
}

extension DetailsPresenter: DetailsPresenterInterface {
    var viewModelDriver: Driver<DetailsViewModel> {
        return interactor.detailsModelDriver.map {model in
            return DetailsViewModel(model: model, delegate: self)
        }
    }
}

extension DetailsPresenter: DetailsViewModelDelegate {
    func didTapOwner() {
        if let owner = interactor.repositoryOwner {
            wireframe.navigate(to: .owner(owner: owner))
        }
    }
}
