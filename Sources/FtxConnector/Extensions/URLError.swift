import Foundation

extension URLError.Code {
    static var rateLimited: URLError.Code {
        return URLError.Code(rawValue: 429)
    }
}
