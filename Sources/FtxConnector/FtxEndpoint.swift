import Foundation
import CryptoKit

public enum FtxEndpoint: String {
    case account = "/api/account"
    
    public func signature(ts: Int, secret: String) -> String? {
        guard let payload = "\(ts)GET\(self.rawValue)".data(using: .utf8) else {
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
