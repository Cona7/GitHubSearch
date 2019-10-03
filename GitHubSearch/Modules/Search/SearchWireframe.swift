import UIKit

final class SearchWireframe: Wireframe {
    static func setupModule() -> UIViewController {
        let viewController = SearchViewController(nibName: nil, bundle: nil)
        let navigationController = NavigationController(rootViewController: viewController)
        let wireframe = SearchWireframe(viewController: viewController)

        let interactor = SearchInteractor()
        let presenter = SearchPresenter(wireframe: wireframe, interactor: interactor)
        viewController.presenter = presenter

        return navigationController
    }
}

extension SearchWireframe: SearchWireframeInterface {
    func navigate(to option: SearchNavigationOption) {
        switch option {
        case .filter(let delegate):
            navigationController?.pushViewController(FilterWireframe.setupModule(delegate: delegate), animated: true)
        case .repoDetails(let repositoryModel):
            navigationController?.pushViewController(DetailsWireframe.setupModule(detailsState: .repository(repositoryModel: repositoryModel)), animated: true)
        case .userDetails(let owner):
            navigationController?.pushViewController(DetailsWireframe.setupModule(detailsState: .user(owner: owner)), animated: true)
        }
    }
}
