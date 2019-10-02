import RxCocoa
import UIKit

enum FilterNavigationOption {
    case done
}

protocol FilterWireframeInterface {
    func navigate(to option: FilterNavigationOption)
}

protocol FilterPresenterInterface {
    var viewModelDriver: Driver<FilterViewModel> { get }
}

protocol FilterInteractorInterface {
}

protocol FilterViewModelDelegate: class {
    func didTapSave()

    func didChangeValue(index: Int, filterType: FilterType)
}
