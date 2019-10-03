import UIKit
import SnapKit
import SimpleDataSource

struct TitleDetailsTableViewCelViewModel {
    let titleName: String
    let entityName: String

    var didTapEnity: (() -> Void)

    init(titleName: String, entityName: String, didTapEnity: @escaping (() -> Void)) {
        self.titleName = titleName
        self.entityName = entityName

        self.didTapEnity = didTapEnity
    }
}

extension TitleDetailsTableViewCelViewModel: DequeuableTableViewCellViewModel {
    func configure(cell: TitleDetailsTableViewCell) {
        cell.setupCell()
        cell.present(viewModel: self)
    }
}

class TitleDetailsTableViewCell: UITableViewCell {

    var viewModel: TitleDetailsTableViewCelViewModel?

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldFont(size: 36)
        label.textColor = .darkText
        return label
    }()

    lazy var entityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFont(ofSize: 24)
        label.textColor = .darkText
        return label
    }()

    lazy var entityButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.tintColor = .darkText

        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

        return button
    }()

    func setupCell() {
        selectionStyle = .none

        addSubviews()
        layout()
    }

    func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(entityLabel)
        contentView.addSubview(entityButton)
    }

    func layout() {
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.left.top.right.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 24, bottom: 0, right: 24))
        }

        entityLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 24, bottom: 8, right: 0))
        }

        entityButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().inset(24)
            make.height.equalTo(entityLabel.snp.height)
            make.width.equalTo(entityLabel.snp.width)
        }
    }

    @objc
    func didTapButton() {
        viewModel?.didTapEnity()
    }

    func present(viewModel: TitleDetailsTableViewCelViewModel) {
        self.viewModel = viewModel

        titleLabel.text = viewModel.titleName
        entityLabel.text = viewModel.entityName
    }
}
