import RxCocoa
import UIKit

enum DetailsNavigationOption {
    case owner(owner: Owner)
}

protocol DetailsWireframeInterface {
    func navigate(to option: DetailsNavigationOption)
}

protocol DetailsPresenterInterface {
    var viewModelDriver: Driver<DetailsViewModel> { get }
}

protocol DetailsInteractorInterface {
    var detailsModelDriver: Driver<DetailsModel> { get }

    var repositoryOwner: Owner? { get }
}

protocol DetailsViewModelDelegate: class {
    func didTapOwner()
}
