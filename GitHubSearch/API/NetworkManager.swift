import Alamofire
import RxSwift

class NetworkManager {
    static func performRequest<T: Codable>(
        url: String,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil
        ) -> Single<T> {
        return Single.create { observer in
            Alamofire
                .request(
                    url,
                    method: method,
                    parameters: parameters,
                    encoding: URLEncoding(destination: .queryString)
                )
                .validate()
                .responseData { response in
                    print(response)
                    observer(.success(response))
            }

            return Disposables.create()
            }
            .flatMap(ResponseMapper.data)
            .flatMap(ResponseMapper.codableModel)
    }
}
