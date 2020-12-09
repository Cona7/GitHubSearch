import Foundation
import SwiftUI
import RxSwift
import SDWebImage

class UserDetailsViewModel: ObservableObject {
    let disposeBag = DisposeBag()

    @Published var avatarURL = ""
    @Published var type = ""
    @Published var name = ""
    @Published var followers = ""
    @Published var following = ""
    @Published var repositories = ""
    @Published var ownerUrl: URL?

    init (name: String) {
        getUserDetails(name: name)
    }

    func getUserDetails(name: String) {
        SearchNetworkManager
             .getUserDetails(name: name)
             .subscribe { [unowned self] respone in
                 switch respone {
                 case .success(let value):
                    self.setValues(userDetails: value)
                 case .error(let error):
                     print(error)
                 }
         }.disposed(by: disposeBag)
    }

    func setValues(userDetails: UserDetails) {
        self.avatarURL = userDetails.avatarURL.absoluteString
        self.name = userDetails.name ?? ""
        self.type = userDetails.type
        self.followers = String(userDetails.followers)
        self.following = String(userDetails.following)
        self.repositories = String(userDetails.publicRepos)
        self.ownerUrl = userDetails.ownerUrl
    }
}
