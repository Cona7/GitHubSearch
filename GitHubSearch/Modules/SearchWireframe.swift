import UIKit

final class SearchWireframe: Wireframe {
    static func setupModule() -> UIViewController {
        let viewController = SearchViewController(nibName: nil, bundle: nil)
        let navigationController = NavigationController(rootViewController: viewController)
        let wireframe = SearchWireframe(viewController: navigationController)

        let interactor = SearchInteractor()
        let presenter = SearchPresenter(wireframe: wireframe, interactor: interactor)
        viewController.presenter = presenter

        return navigationController
    }
}

extension SearchWireframe: SearchWireframeInterface {
    func navigate(to option: SearchNavigationOption) {
    }
}
