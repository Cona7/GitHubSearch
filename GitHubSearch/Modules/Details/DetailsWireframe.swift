import UIKit

final class DetailsWireframe: Wireframe {
    static func setupModule(detailsState: DetailsState) -> UIViewController {
        let viewController = DetailsViewController(nibName: nil, bundle: nil)
        let wireframe = DetailsWireframe(viewController: viewController)

        let interactor = DetailsInteractor(detailsState: detailsState)
        let presenter = DetailsPresenter(wireframe: wireframe, interactor: interactor)
        viewController.presenter = presenter

        return viewController
    }
}

extension DetailsWireframe: DetailsWireframeInterface {
    func navigate(to option: DetailsNavigationOption) {
        switch option {
        case .owner(let owner):
            navigationController?.pushViewController(DetailsWireframe.setupModule(detailsState: .user(owner: owner)), animated: true)
        }
    }
}
