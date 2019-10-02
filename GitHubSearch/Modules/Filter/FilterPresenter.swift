import RxSwift
import RxCocoa
import UIKit

final class FilterPresenter {
    private let interactor: FilterInteractorInterface
    private let wireframe: FilterWireframeInterface

    private var filterParameters = FilterParametersDataSource.shared.filterParameters

    init(wireframe: FilterWireframeInterface,
         interactor: FilterInteractorInterface) {
        self.wireframe = wireframe
        self.interactor = interactor
    }
}

extension FilterPresenter: FilterPresenterInterface {
    var viewModelDriver: Driver<FilterViewModel> {
        return .just(FilterViewModel(delegate: self, filterParameters: filterParameters))
    }
}

extension FilterPresenter: FilterViewModelDelegate {
    func didTapSave() {
        FilterParametersDataSource.shared.setSearchValue(search: filterParameters.searchBy)
        FilterParametersDataSource.shared.setSortValue(sort: filterParameters.sortBy)

        wireframe.navigate(to: .done)
    }

    func didChangeValue(index: Int, filterType: FilterType) {
        if filterType == .search {
            filterParameters.searchBy = SearchType(rawValue: index)!
        } else if filterType == .sort {
            filterParameters.sortBy = SortType(rawValue: index)!
        }
    }
}
