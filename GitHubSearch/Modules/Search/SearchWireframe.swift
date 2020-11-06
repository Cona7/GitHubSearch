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
        case .repoDetails(let name, let username):
            navigationController?.pushViewController(DetailsWireframe.setupModule(detailsState: .repository(name: name, username: username)), animated: true)
        case .userDetails(let name, let avatarURL):
            navigationController?.pushViewController(DetailsWireframe.setupModule(detailsState: .user(name: name, avatarURL: avatarURL)), animated: true)
        }
    }
}
