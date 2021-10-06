import Foundation
import CryptoKit

extension HashedAuthenticationCode {
    var hex: String {
        return self.map({ return String(format: "%02hhx", $0) }).joined()
    }
    
    var data: Data {
        return Data(self)
    }
}
