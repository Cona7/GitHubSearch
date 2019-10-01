import Foundation

enum NetworkError: Error {
    case JSONSerialization
    case response(NetworkErrorResponse)
}
