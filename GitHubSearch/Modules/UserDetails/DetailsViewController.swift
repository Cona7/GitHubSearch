import UIKit
import SimpleDataSource
import SDWebImage

final class DetailsViewController: ViewController {
    var presenter: DetailsPresenterInterface!

    var tableViewDataSource = SimpleTableViewDataSource()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()

        return imageView
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero)

        tableView.delegate = self.tableViewDataSource
        tableView.dataSource = self.tableViewDataSource
        tableView.backgroundColor = .light
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false

        return tableView
    }()

    override func setupViewController() {
        super.setupViewController()

        view.backgroundColor = .white

        self.navigationController?.view.backgroundColor = .clear

        presenter
            .viewModelDriver
            .drive(
                onNext: { [weak self] viewModel in
                    self?.present(viewModel: viewModel)
                }
            ).disposed(by: disposeBag)
    }

    override func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(tableView)
    }

    override func layout() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension DetailsViewController {
    func present(viewModel: DetailsViewModel) {

        tableViewDataSource.present(viewModels: viewModel.cellViewModels, onTableView: tableView)

        switch viewModel.state {
        case .user( _, let avatarURL):
            SDWebImageManager
                .shared
                .loadImage(with: avatarURL, options: SDWebImageOptions.continueInBackground, progress: nil) { image, _, _, _, _, _  in
                    if let image = image {
                        self.imageView.image = image
                    }
            }
        default:
            imageView.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(32)
                make.centerX.equalToSuperview()
                make.size.equalTo(160)
            }

            imageView.image = #imageLiteral(resourceName: "GitHub-Mark")
        }
    }
}
