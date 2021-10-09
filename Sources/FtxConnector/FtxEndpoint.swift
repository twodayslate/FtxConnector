import Foundation
import CryptoKit

public enum FtxEndpoint: String {
    case account = "/api/account"
    case subaccounts = "/api/subaccounts"
    case positions = "/api/positions"
    
    public enum FtxEndpointRequestType: String {
        case GET = "GET"
        case POST = "POST"
    }

    /**
     * FTX Signature
     *
     * SHA256 HMAC of the following four strings, using your API secret, as a hex string:
     * * Request timestamp (e.g. 1528394229375)
     * * HTTP method in uppercase (e.g. GET or POST)
     * * Request path, including leading slash and any URL parameters but not including the hostname (e.g. /account)
     * * (POST only) Request body (JSON-encoded)
     *
     * - SeeAlso: https://docs.ftx.com/#authentication
     *
     * - parameter ts: The request timestamp
     * - parameter secret: API secret, as a hex string
     * - parameter requestType: HTTP method
     * - parameter queryItems: URL parameters
     *
     * - returns: The SHA256 HMAC
     */
    public func signature(ts: Int, secret: String, requestType: FtxEndpointRequestType = .GET, queryItems: [URLQueryItem]?=nil) -> String? {
        var queryString = ""
        if let queryItems = queryItems {
            var c = URLComponents()
            c.queryItems = queryItems
            queryString = c.url?.absoluteString ?? ""
        }
        // todo: Manage POST data
        guard let payload = "\(ts)\(requestType.rawValue)\(self.rawValue)\(queryString)".data(using: .utf8) else {
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
