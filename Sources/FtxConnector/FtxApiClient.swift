import Foundation

public struct FtxRestApiClient {
    public let key: String
    public let secret: String
    public var session: URLSession = URLSession.shared
    internal var host = "https://ftx.com"
    
    public var ts: Int {
        return Int(Date().timeIntervalSince1970*1000)
    }
    
    public func account() async throws -> FtxResponse<FtxAccount> {
        guard let url = URL(string: self.host + FtxEndpoint.account.rawValue) else {
            throw URLError(.badURL)
        }
        let ts = self.ts
        guard let hmac = FtxEndpoint.account.signature(ts: ts, secret: self.secret) else {
            throw URLError(.userAuthenticationRequired)
        }
        var request = URLRequest(url: url)
        request.addValue(self.key, forHTTPHeaderField: "FTX-KEY")
        request.addValue(hmac, forHTTPHeaderField: "FTX-SIGN")
        request.addValue("\(ts)", forHTTPHeaderField: "FTX-TS")

        let (data, response) = try await self.session.data(for: request)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(FtxResponse<FtxAccount>.self, from: data)
    }
}
