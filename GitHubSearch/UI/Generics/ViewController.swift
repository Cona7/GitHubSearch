import RxSwift
import UIKit

class ViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
    }

    func setupViewController() {
        addSubviews()
        layout()
    }

    func addSubviews() {}

    func layout() {}
}
