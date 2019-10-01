import UIKit

class ApplicationManager {
    static var shared: ApplicationManager!

    let window: UIWindow

    var topMostViewController: UIViewController? {
        return window.rootViewController?.topMostViewController
    }

    var host: String {
        return "https://api.github.com"
    }

    init(window: UIWindow) {
        self.window = window
    }

    func setRootViewController() {
        let viewController = rootViewController()

        if window.rootViewController?.topMostViewController != nil {
            UIView.setAnimationsEnabled(false)

            UIView.transition(
                with: window,
                duration: 0.5,
                options: .transitionCrossDissolve,
                animations: {
                    self.window.rootViewController = viewController
            },
                completion: { _ in
                    UIView.setAnimationsEnabled(true)
            }
            )
        } else {
            window.rootViewController = viewController
        }
    }

    private func rootViewController() -> UIViewController {
        return SearchWireframe.setupModule()
    }
}
