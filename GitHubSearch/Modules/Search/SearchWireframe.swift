import UIKit
import SwiftUI

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
            let swiftUIView = RepositoryDetailsView(viewModel: RepositoryDetailsViewModel(name: name, owner: username))
            let viewCtrl = UIHostingController(rootView: swiftUIView)
            navigationController?.pushViewController(viewCtrl, animated: true)
        case .userDetails(let name, let avatarURL):
            let swiftUIView = DetailsView(viewModel: UserDetailsViewModel(name: name))
            let viewCtrl = UIHostingController(rootView: swiftUIView)
            navigationController?.pushViewController(viewCtrl, animated: true)
        }
    }
}
