import UIKit
import SimpleDataSource
import SDWebImage

struct RepositoryTableViewCellViewModel {
    let imageUrl: URL?
    let title: String
    let ownerName: String
    let info: String

    var didTapCell: (() -> Void)?

    init(imageUrl: URL?, title: String, ownerName: String, forksCount: Int, watchersCount: Int, issuesCount: Int, didTapCell: (() -> Void)?) {
        self.imageUrl = imageUrl
        self.title = title
        self.ownerName = ownerName
        self.info = "forks: \(String(forksCount)), watchers: \(String(watchersCount)), issues: \(String(issuesCount))"

        self.didTapCell = didTapCell
    }
}

extension RepositoryTableViewCellViewModel: DequeuableTableViewCellViewModel {
    func configure(cell: RepositoryTableViewCell) {
        cell.setupCell()
        cell.present(viewModel: self)
    }
}

class RepositoryTableViewCell: UITableViewCell {
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .gray
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldFont(size: 14)
        label.textColor = .darkText
        return label
    }()

    lazy var ownerLabel: UILabel = {
        let label = UILabel()
        label.font = .regularFont(ofSize: 14)
        label.textColor = .darkText
        return label
    }()

    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .regularFont(ofSize: 12)
        label.textColor = .darkText
        return label
    }()

    lazy var separator: UIView = {
        let view = UIView()

        view.backgroundColor = .lightGray

        return view
    }()

    override func prepareForReuse() {
        super.prepareForReuse()

        self.avatarImageView.image = nil
    }

    func setupCell() {
        self.addSubviews()
        self.layout()

        contentView.translatesAutoresizingMaskIntoConstraints = true

        self.backgroundColor = .clear
        self.selectionStyle = .none
    }

    func addSubviews() {
        self.addSubview(avatarImageView)
        self.addSubview(titleLabel)
        self.addSubview(ownerLabel)
        self.addSubview(infoLabel)
        self.addSubview(separator)
    }

    func layout() {
        self.avatarImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(UIEdgeInsets(top: 16, left: 24, bottom: 0, right: 0))
            make.size.equalTo(48)
        }

        self.titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.ownerLabel.snp.top)
            make.left.equalTo(self.avatarImageView.snp.right).offset(8)
            make.right.equalToSuperview().inset(24)
        }

        self.ownerLabel.snp.makeConstraints { make in
            make.left.right.equalTo(self.titleLabel)
            make.centerY.equalTo(avatarImageView.snp.centerY)
        }

        self.infoLabel.snp.makeConstraints { make in
            make.left.right.equalTo(self.titleLabel)
            make.top.equalTo(self.ownerLabel.snp.bottom).offset(4)
        }

        self.separator.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24))
            make.top.equalTo(self.avatarImageView.snp.bottom).offset(16)
            make.height.equalTo(1)
        }
    }
}

extension RepositoryTableViewCell {
    func present(viewModel: RepositoryTableViewCellViewModel) {
        if let imageUrl = viewModel.imageUrl {
            SDWebImageManager
                .shared
                .loadImage(with: imageUrl, options: SDWebImageOptions.continueInBackground, progress: nil) { image, _, _, _, _, _  in
                    if let image = image {
                        self.avatarImageView.image = image
                    }
            }
        } else {
            self.avatarImageView.image = nil
        }

        self.titleLabel.text = viewModel.title
        self.ownerLabel.text = viewModel.ownerName
        self.infoLabel.text = viewModel.info
    }
}