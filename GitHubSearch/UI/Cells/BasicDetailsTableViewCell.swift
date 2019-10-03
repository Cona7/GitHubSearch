import UIKit
import SnapKit
import SimpleDataSource

struct BasicDetailsTableViewCellViewModell {
    let text: String
}

extension BasicDetailsTableViewCellViewModell: DequeuableTableViewCellViewModel {
    func configure(cell: BasicDetailsTableViewCell) {
        cell.setupCell()
        cell.present(viewModel: self)
    }
}

class BasicDetailsTableViewCell: UITableViewCell {
    lazy var label: UILabel = {
        let label = UILabel()

        label.font = .regularFont(ofSize: 16)
        label.textColor = .darkText
        label.numberOfLines = 0

        return label
    }()

    func setupCell() {
        selectionStyle = .none

        addSubviews()
        layout()
    }

    func addSubviews() {
        contentView.addSubview(label)
    }

    func layout() {
        label.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 24, bottom: 4, right: 24))
        }
    }

    func present(viewModel: BasicDetailsTableViewCellViewModell) {
        label.text = viewModel.text
    }
}
