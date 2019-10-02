import UIKit

final class FilterWireframe: Wireframe {
    static func setupModule(delegate: SearchFilterDelegate) -> UIViewController {
        let viewController = FilterViewController(nibName: nil, bundle: nil)
        let wireframe = FilterWireframe(delegate: delegate, viewController: viewController)

        let interactor = FilterInteractor()
        let presenter = FilterPresenter(wireframe: wireframe, interactor: interactor)
        viewController.presenter = presenter

        return viewController
    }

    weak var delegate: SearchFilterDelegate?

    init(delegate: SearchFilterDelegate, viewController: UIViewController) {
        self.delegate = delegate

        super.init(viewController: viewController)
    }
}

extension FilterWireframe: FilterWireframeInterface {
    func navigate(to option: FilterNavigationOption) {
        switch option {
        case .done:
            delegate?.didSaveFilterParameters()

            navigationController?.popViewController(animated: true)
        }
    }
}
