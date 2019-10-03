import UIKit
import SnapKit
import SimpleDataSource

struct LinkedDetailsTableViewCellViewModell {
    let url: URL
}

extension LinkedDetailsTableViewCellViewModell: DequeuableTableViewCellViewModel {
    func configure(cell: LinkedDetailsTableViewCell) {
        cell.setupCell()
        cell.present(viewModel: self)
    }
}

class LinkedDetailsTableViewCell: UITableViewCell {
    lazy var linkedLabel = LinkedLabel()

    func setupCell() {
        selectionStyle = .none

        addSubviews()
        layout()
    }

    func addSubviews() {
        contentView.addSubview(linkedLabel)
    }

    func layout() {
        linkedLabel.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 24, bottom: 4, right: 24))
        }
    }

    func present(viewModel: LinkedDetailsTableViewCellViewModell) {
        linkedLabel.setupLabel(url: viewModel.url)
    }
}
