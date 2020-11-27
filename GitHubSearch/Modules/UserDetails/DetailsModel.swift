import Foundation

struct DetailsModel {
    var repositoryDetails: RepositoryDetails?
    var userDetails: UserDetails?

    var state: DetailsState

    init(state: DetailsState, repositoryDetails: RepositoryDetails? = nil, userDetails: UserDetails? = nil) {
        self.state = state
        self.repositoryDetails = repositoryDetails
        self.userDetails = userDetails
    }
}
