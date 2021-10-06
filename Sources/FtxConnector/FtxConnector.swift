import Foundation
import CryptoKit

public struct FtxConnector {
    public static func restClient(key: String, secret: String) -> FtxRestApiClient {
        return FtxRestApiClient(key: key, secret: secret)
    }
}
