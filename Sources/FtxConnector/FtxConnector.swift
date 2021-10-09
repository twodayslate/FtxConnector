import Foundation
import CryptoKit

public struct FtxConnector {
    public static func restClient(key: String, secret: String) -> FtxRestApiClient {
        return FtxRestApiClient(key: key, secret: secret)
    }
    
    public static var timeEndpoint = "https://otc.ftx.com/api/time"
    
    /// Gets the time from `timeEndpoint`
    public static func time() async throws -> FtxResponse<Date> {
        let (data, _) = try await URLSession.shared.data(from: URL(string: Self.timeEndpoint)!)

        // todo: convert to actual timestamp/date
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            let formatter = DateFormatter()
            // 2021-10-09T20:46:59.545652+00:00
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
            
            guard let date = formatter.date(from: dateString) else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
            }
            
            return date
        }
        return try decoder.decode(FtxResponse<Date>.self, from: data)
    }
}
