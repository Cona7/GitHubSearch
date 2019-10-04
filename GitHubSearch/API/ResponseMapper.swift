import RxSwift
import Alamofire
import Foundation

class ResponseMapper {
    static func codableModel<T: Codable>(from data: Data) -> Single<T> {
        do {
            let decoder = JSONDecoder()

            let response = try decoder.decode(T.self, from: data)

            return .just(response)
        } catch let error {
            return .error(error)
        }
    }

    static func data(from response: DataResponse<Data>) -> Single<Data> {
        return Single.create { observer in
            do {
                switch response.result {
                case .success(let data):
                        observer(.success(data))
                case .failure(let error):
                    if let data = response.data {
                        let genericErrorResponse = try JSONDecoder().decode(NetworkErrorResponse.self, from: data)

                        observer(.error(NetworkError.response(genericErrorResponse)))
                    } else {
                        observer(.error(error))
                    }
                }
            } catch let error {
                observer(.error(error))
            }

            return Disposables.create()
        }
    }
}
