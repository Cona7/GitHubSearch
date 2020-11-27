import Foundation
import RxSwift
import RxCocoa
import RxRelay

final class DetailsInteractor {
    private var detailsModel: BehaviorRelay<DetailsModel>

    let disposeBag = DisposeBag()

    init(detailsState: DetailsState) {
        detailsModel = BehaviorRelay(value: DetailsModel(state: detailsState))

        switch detailsState {
        case .repository(let name, let username):
            self.getRepositoryDetails(name: name, owner: username)
        case .user(let name, _):
            getUserDetails(name: name)
        }
    }

    func getRepositoryDetails(name: String, owner: String) {
        SearchNetworkManager
            .getRepositoryDetails(repoName: name, owner: owner)
            .subscribe { [unowned self] respone in
                switch respone {
                case .success(let value):
                    self.detailsModel.accept(DetailsModel(state: self.detailsModel.value.state, repositoryDetails: value))
                case .error(let error):
                    print(error)
                }
        }.disposed(by: disposeBag)
    }

    func getUserDetails(name: String) {
        SearchNetworkManager
             .getUserDetails(name: name)
             .subscribe { [unowned self] respone in
                 switch respone {
                 case .success(let value):
                     self.detailsModel.accept(DetailsModel(state: self.detailsModel.value.state, userDetails: value))
                 case .error(let error):
                     print(error)
                 }
         }.disposed(by: disposeBag)
    }
}

extension DetailsInteractor: DetailsInteractorInterface {
    var detailsModelDriver: Driver<DetailsModel> {
        return detailsModel.asDriver()
    }

    var repositoryOwner: Owner? {
        return detailsModel.value.repositoryDetails?.owner
    }
}
