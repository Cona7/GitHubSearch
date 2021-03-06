import UIKit
import SnapKit
import SimpleDataSource

final class SearchViewController: ViewController {
    var presenter: SearchPresenterInterface!

    var tableViewDataSource = SimpleTableViewDataSource()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()

        imageView.image = #imageLiteral(resourceName: "GitHub-Mark")

        return imageView
    }()

    lazy var label: UILabel = {
        let label = UILabel()

        label.font = .boldFont(size: 36)
        label.textColor = .darkText

        return label
    }()

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)

        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = .clear
        searchBar.barTintColor = .clear

        searchBar.delegate = self

        return searchBar
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero)

        tableView.delegate = self.tableViewDataSource
        tableView.dataSource = self.tableViewDataSource
        tableView.backgroundColor = .light
        tableView.separatorStyle = .none

        return tableView
    }()

    override func setupViewController() {
        super.setupViewController()

        self.view.backgroundColor = .white

        presenter
            .viewModelDriver
            .drive(
                onNext: { [weak self] viewModel in
                    self?.present(viewModel: viewModel)
                }
            ).disposed(by: disposeBag)

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }

    override func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(label)
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }

    override func layout() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
            make.size.equalTo(160)
        }

        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: 120, left: 24, bottom: 0, right: 24))
        }

        searchBar.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(label.snp.bottom).offset(8)
            make.height.equalTo(32)
        }

        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom).offset(16)
        }
    }

    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SearchViewController {
    func present(viewModel: SearchViewModel) {
        navigationItem.rightBarButtonItem = viewModel.rightBarButton

        label.text = viewModel.searchLabel

        searchBar.placeholder = viewModel.searchPlaceholder

        if viewModel.shouldClearQuery {
            searchBar.text = ""
        }

        tableViewDataSource.present(viewModels: viewModel.cellViewModels, onTableView: self.tableView)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.didTextChangeSearchBar(query: searchText)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
