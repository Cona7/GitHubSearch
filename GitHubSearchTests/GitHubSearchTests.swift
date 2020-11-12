import XCTest
import Nimble
import RxBlocking
import RxTest

@testable import GitHubSearch

class GitHubSearchTests: XCTestCase {
    func testGetRepos() {
        expect(
            try SearchNetworkManager
                    .getRepositories(query: "repo", sort: SortType.stars.query)
                    .toBlocking().first()
        ).toNot(beNil())
    }

    func testGetUsers() {
        expect(
            try SearchNetworkManager.getUsers(query: "Cona")
                .toBlocking().first()
        ).toNot(beNil())
    }

    func testGetUserDetails() {
        expect(
            try SearchNetworkManager.getUserDetails(name: "Cona7")
                .toBlocking().first()
        ).toNot(beNil())
    }

    func testGetRepoDetails() {
        expect(
            try SearchNetworkManager
                .getRepositoryDetails(repoName: "GitHubSearch", owner: "Cona7")
                .toBlocking().first()
        ).toNot(beNil())
    }

//    func testRepositoryModel() {
//        expect(Repository.(score: 3.65)) == "Score: 3.65"
//        expect(SearchListModel.getUserDetails(score: 3.00)) == "Score: 3.0"
//        expect(SearchListModel.getUserDetails(score: nil)) == ""
//    }
//
//    func testSearchCellRepoDetails() {
//        expect(SearchListModel.getRepoDetails(forks: 33, watchers: 22, issues: 55))
//            == "forks: 33, watchers: 22, issues: 55"
//        expect(SearchListModel.getRepoDetails(forks: 5, watchers: 0, issues: 0))
//            == "forks: 5, watchers: 0, issues: 0"
//    }
}
