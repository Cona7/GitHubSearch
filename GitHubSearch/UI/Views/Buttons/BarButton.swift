import UIKit

class BarButtonItem: UIBarButtonItem {
    var onTapCallback: (() -> Void)?

    static func create(title: String, withTapCallback callback: @escaping () -> Void) -> BarButtonItem {
        let button = BarButtonItem(title: title, style: .plain, target: nil, action: nil)

        button.present(onTapCallback: callback)

        return button
    }

    static func create(image: UIImage, withTapCallback callback: @escaping () -> Void) -> BarButtonItem {
        let button = BarButtonItem(image: image, style: .plain, target: nil, action: nil)

        button.present(onTapCallback: callback)

        return button
    }

    func present(onTapCallback: (() -> Void)?) {
        self.onTapCallback = onTapCallback

        target = self
        action = #selector(didTapBarButtonItem)
    }

    @objc
    func didTapBarButtonItem() {
        onTapCallback?()
    }
}
