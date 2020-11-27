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
                    observer(.success(response))
            }

            return Disposables.create()
            }
            .flatMap(ResponseMapper.data)
            .flatMap(ResponseMapper.codableModel)
    }

    private static let cache = NSCache<NSString, UIImage>()

    static func downloadImage(fromURLString urlString: String, completed: @escaping (UIImage?) -> Void) {

        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }

        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, _ in

            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }

            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }

        task.resume()
    }
}
