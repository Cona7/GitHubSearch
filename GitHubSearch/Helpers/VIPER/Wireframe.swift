import UIKit

protocol WireframeInterface {
    func present(error: Error)
    func present(viewController: UIViewController)
    func present(viewController: UIViewController, animation: Bool)
}

class Wireframe {
    unowned var viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension Wireframe {
    var navigationController: UINavigationController? {
        return viewController.navigationController
    }
}

extension UIViewController {
    func presentWireframe(_ wireframe: Wireframe, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
}

extension UINavigationController {
    func pushWireframe(_ wireframe: Wireframe, animated: Bool = true) {
        self.pushViewController(wireframe.viewController, animated: animated)
    }

    func setRootWireframe(_ wireframe: Wireframe, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }
}

extension Wireframe: WireframeInterface {
    @objc
    func present(error: Error) {

        // TODO presentable error
        let alertController = UIAlertController(title: "Error",
                                                message: "Unexpected error occured",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        viewController.topMostViewController.present(alertController, animated: true, completion: nil)
    }

    func present(viewController: UIViewController, animation: Bool = true) {
        self.viewController.topMostViewController.present(viewController, animated: animation, completion: nil)
    }

    func present(viewController: UIViewController) {
        present(viewController: viewController, animation: true)
    }
}
