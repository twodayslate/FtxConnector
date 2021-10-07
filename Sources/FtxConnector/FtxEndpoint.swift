import Foundation
import CryptoKit

public enum FtxEndpoint: String {
    case account = "/api/account"
    case subaccounts = "/api/subaccounts"
    case positions = "/api/positions"

    public func signature(ts: Int, secret: String, queryItems: [URLQueryItem]?=nil) -> String? {
        var queryString = ""
        if let queryItems = queryItems {
            var c = URLComponents()
            c.queryItems = queryItems
            queryString = c.url?.absoluteString ?? ""
        }
        guard let payload = "\(ts)GET\(self.rawValue)\(queryString)".data(using: .utf8) else {
            return nil
        }
        guard let secretData = secret.data(using: .utf8) else {
            return nil
        }
        let key = SymmetricKey(data: secretData)
        var hmac = HMAC<SHA256>(key: key)
        hmac.update(data: payload)
        let sig = hmac.finalize()
        return sig.hex
    }
}
