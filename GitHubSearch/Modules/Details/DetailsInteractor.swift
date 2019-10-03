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
        case .repository(let repositoryModel):
            self.getRepositoryDetails(name: repositoryModel.name, owner: repositoryModel.owner.name)
        case .user(let owner):
            getUserDetails(owner: owner)
        }
    }

    func getRepositoryDetails(name: String, owner: String) {
        SearchNetworkManager
            .getRepositoryDetails(repoName: name, owner: owner)
            .subscribe { [unowned self] respone in
                switch respone {
                case .success(let value):
                    print(value)
                    self.detailsModel.accept(DetailsModel(state: self.detailsModel.value.state, repositoryDetails: value))
                case .error(let error):
                    print(error)
                }
        }.disposed(by: disposeBag)
    }

    func getUserDetails(owner: Owner) {
        SearchNetworkManager
             .getUserDetails(owner: owner)
             .subscribe { [unowned self] respone in
                 switch respone {
                 case .success(let value):
                     print(value)
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
