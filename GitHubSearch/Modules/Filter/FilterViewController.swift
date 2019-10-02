import UIKit
import SimpleDataSource

final class FilterViewController: ViewController {
    var presenter: FilterPresenterInterface!

    var tableViewDataSource = SimpleTableViewDataSource()

     lazy var tableView: UITableView = {
         let tableView = UITableView(frame: CGRect.zero, style: .grouped)

         tableView.dataSource = self.tableViewDataSource
         tableView.backgroundColor = .light
         tableView.separatorStyle = .none
         tableView.isScrollEnabled = false

         return tableView
     }()

    override func setupViewController() {
        super.setupViewController()

        view.backgroundColor = .white

        presenter
            .viewModelDriver
            .drive(
                onNext: { [weak self] viewModel in
                    self?.present(viewModel: viewModel)
                }
        ).disposed(by: disposeBag)
    }

    override func addSubviews() {
        view.addSubview(tableView)
    }

    override func layout() {
        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
    }
}

extension FilterViewController {
    func present(viewModel: FilterViewModel) {
        navigationItem.rightBarButtonItem = viewModel.rightBarButton

        tableViewDataSource.present(viewModels: viewModel.cellViewModels, onTableView: tableView)

        tableView.reloadData()
    }
}
