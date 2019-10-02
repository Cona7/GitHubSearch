import UIKit
import SnapKit
import SimpleDataSource

struct FilterTableViewCellViewModel {
    let name: String
    let segmentedControlItems: [String]
    let selectedSegmentedIndex: Int
    let filterType: FilterType

    var didChangeValue: (Int, FilterType) -> Void
}

extension FilterTableViewCellViewModel: DequeuableTableViewCellViewModel {
    func configure(cell: FilterTableViewCell) {
        cell.setupCell()
        cell.present(viewModel: self)
    }
}

class FilterTableViewCell: UITableViewCell {

    var viewModel: FilterTableViewCellViewModel?

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFont(ofSize: 17)
        return label
    }()

    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()

        segmentedControl.addTarget(self, action: #selector(didValueChange), for: .valueChanged)

        return segmentedControl
    }()

    func setupCell() {
        selectionStyle = .none

        addSubviews()
        layout()
    }

    func addSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(segmentedControl)
    }

    func layout() {
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.left.top.right.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 32, bottom: 0, right: 32))
        }
    }

    func remakeConstraints() {
        segmentedControl.snp.remakeConstraints { (make) -> Void in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.bottom.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 32, bottom: 12, right: 32))
            make.height.equalTo(36)
        }
    }

    @objc
    func didValueChange() {
        if let viewModel = viewModel {
            viewModel.didChangeValue(segmentedControl.selectedSegmentIndex, viewModel.filterType)
        }
    }

    func present(viewModel: FilterTableViewCellViewModel) {
        self.viewModel = viewModel

        nameLabel.text = viewModel.name

        segmentedControl.removeAllSegments()
        segmentedControl.insertSegments(items: viewModel.segmentedControlItems)

        segmentedControl.selectedSegmentIndex = viewModel.selectedSegmentedIndex

        remakeConstraints()
    }
}
