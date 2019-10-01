import UIKit

final class SearchViewController: ViewController {
    var presenter: SearchPresenterInterface!

    override func setupViewController() {
        super.setupViewController()

        self.view.backgroundColor = .white

        title = "Search"

        presenter
            .viewModelDriver
            .drive(
                onNext: { [weak self] viewModel in
                    self?.present(viewModel: viewModel)
                }
            ).disposed(by: disposeBag)
    }
}

extension SearchViewController {
    func present(viewModel: SearchViewModel) {
    }
}
