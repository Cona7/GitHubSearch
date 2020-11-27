import Foundation
import SimpleDataSource

struct DetailsViewModel {

    var cellViewModels = [AnyDequeuableTableViewCellViewModel]()

    var state: DetailsState

    init(model: DetailsModel, delegate: DetailsViewModelDelegate) {
        if case .repository = model.state, let model = model.repositoryDetails {
            cellViewModels = [
                TitleDetailsTableViewCelViewModel(titleName: "Owner", entityName: model.owner.name, didTapEnity: { delegate.didTapOwner() }).tableViewPresentable,
                TitleDetailsTableViewCelViewModel(titleName: "Repository", entityName: model.name, didTapEnity: {}).tableViewPresentable,
                BasicDetailsTableViewCellViewModell(text: model.description ?? "").tableViewPresentable,
                BasicDetailsTableViewCellViewModell(text: "Programing Language: \(model.language ?? "")").tableViewPresentable
            ]

            if let created = model.created, let updated = model.updated {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                dateFormatter.calendar = Calendar(identifier: .iso8601)
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

                if let dateCreated = dateFormatter.date(from: created), let dateUpdated = dateFormatter.date(from: updated) {
                    let calendar = Calendar.current
                    let createdDate = "\(calendar.component(.month, from: dateCreated))/\(calendar.component(.year, from: dateCreated))"
                    let updatedDate = "\(calendar.component(.month, from: dateUpdated))/\(calendar.component(.year, from: dateUpdated))"

                    cellViewModels.append(BasicDetailsTableViewCellViewModell(text: "Created: \(createdDate)").tableViewPresentable)
                    cellViewModels.append(BasicDetailsTableViewCellViewModell(text: "Last Update: \(updatedDate)").tableViewPresentable)
                }
            }

            if let repoURL = model.repoURL {
                cellViewModels.append(LinkedDetailsTableViewCellViewModell(url: repoURL).tableViewPresentable)
            }
        } else if let model = model.userDetails {
            cellViewModels = [
                TitleDetailsTableViewCelViewModel(titleName: model.type, entityName: model.login, didTapEnity: { delegate.didTapOwner() }).tableViewPresentable,
                BasicDetailsTableViewCellViewModell(text: "Name: \(model.name ?? "/")").tableViewPresentable,
                BasicDetailsTableViewCellViewModell(text: "Followers: \(String(model.followers))").tableViewPresentable,
                LinkedDetailsTableViewCellViewModell(url: model.ownerUrl).tableViewPresentable
            ]
        }

        self.state = model.state
    }
}
