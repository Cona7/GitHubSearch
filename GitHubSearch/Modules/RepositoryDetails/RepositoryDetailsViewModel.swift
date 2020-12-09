import Foundation
import SwiftUI
import RxSwift
import SDWebImage

class RepositoryDetailsViewModel: ObservableObject {
    let disposeBag = DisposeBag()

    @Published var ownerAvatarURL = ""
    @Published var ownerName = ""
    @Published var ownerType = ""

    @Published var name = ""
    @Published var description = ""
    @Published var createdAt = ""
    @Published var updatedAt = ""
    @Published var programmingLanguage = ""

    @Published var repoUrl: URL?

    init (name: String, owner: String) {
        getRepositoryDetails(name: name, owner: owner)
    }

    func getRepositoryDetails(name: String, owner: String) {
        SearchNetworkManager
            .getRepositoryDetails(repoName: name, owner: owner)
            .subscribe { [unowned self] respone in
                switch respone {
                case .success(let value):
                    self.setRepositoryValues(repositoryDetails: value)
                case .error(let error):
                    print(error)
                }
            }.disposed(by: disposeBag)
    }

    func setRepositoryValues(repositoryDetails: RepositoryDetails) {
        self.ownerAvatarURL = repositoryDetails.owner.avatarURL.absoluteString
        self.ownerName = repositoryDetails.owner.name
        self.ownerType = repositoryDetails.owner.type

        self.name = repositoryDetails.name
        self.description = repositoryDetails.description ?? ""

        self.programmingLanguage = repositoryDetails.language ?? ""
        self.createdAt = getReadableDate(repositoryDetails.created ?? "")
        self.updatedAt = getReadableDate(repositoryDetails.updated ?? "")

        self.repoUrl = repositoryDetails.repoURL
    }

    func getReadableDate(_ dateString: String) -> String {
        guard let dateCreated = dateFormatter.date(from: dateString) else {
            return ""
        }

        let calendar = Calendar.current

        return "\(calendar.component(.month, from: dateCreated))/\(calendar.component(.year, from: dateCreated))"

    }

    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        return dateFormatter
    }
}
