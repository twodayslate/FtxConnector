import Foundation

public struct FtxRestApiClient {
    public let key: String
    public let secret: String
    public var session: URLSession = URLSession.shared
    internal var host = "https://ftx.com"
    
    internal func ts() -> Int {
        return Int(Date().timeIntervalSince1970*1000)
    }
    
    internal func setupRequest(endpoint: FtxEndpoint, queryItems: [URLQueryItem]?=nil, subaccount: FtxSubaccount? = nil) throws -> URLRequest {
        guard var components = URLComponents(string: self.host) else {
            throw URLError(.badURL)
        }
        components.path = components.path + endpoint.rawValue
        components.queryItems = queryItems
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        let ts = self.ts()
        guard let hmac = endpoint.signature(ts: ts, secret: self.secret, queryItems: queryItems) else {
            throw URLError(.userAuthenticationRequired)
        }
        var request = URLRequest(url: url)
        request.addValue(self.key, forHTTPHeaderField: "FTX-KEY")
        request.addValue(hmac, forHTTPHeaderField: "FTX-SIGN")
        print("hmac", hmac)
        request.addValue("\(ts)", forHTTPHeaderField: "FTX-TS")
        if let subaccount = subaccount {
            request.addValue(subaccount.encodedNickname, forHTTPHeaderField: "FTX-SUBACCOUNT")
        }
        return request
    }
    
    internal func check(response: URLResponse) throws {
        // You are being rate limited
        // https://help.ftx.com/hc/en-us/articles/360052595091-2020-11-20-Ratelimit-Updates
        if (response as? HTTPURLResponse)?.statusCode == 429 {
            throw URLError(.rateLimited)
        }
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
    }
    
    public func account(subaccount: FtxSubaccount? = nil) async throws -> FtxResponse<FtxAccount> {
        let request = try self.setupRequest(endpoint: .account, subaccount: subaccount)
        
        let (data, response) = try await self.session.data(for: request)

        try self.check(response: response)

        return try JSONDecoder().decode(FtxResponse<FtxAccount>.self, from: data)
    }
    
    public func positions(showAvgPrice: Bool = false, subaccount: FtxSubaccount? = nil) async throws -> FtxResponse<[FtxPosition]> {
        let request = try self.setupRequest(endpoint: .positions, queryItems: [URLQueryItem(name: "showAvgPrice", value: "\(showAvgPrice)".lowercased())], subaccount: subaccount)

        let (data, response) = try await self.session.data(for: request)

        try self.check(response: response)

        return try JSONDecoder().decode(FtxResponse<[FtxPosition]>.self, from: data)
    }
    
    public func subaccounts(subaccount: FtxSubaccount? = nil) async throws -> FtxResponse<[FtxSubaccount]> {
        let request = try self.setupRequest(endpoint: .subaccounts, subaccount: subaccount)

        let (data, response) = try await self.session.data(for: request)

        try self.check(response: response)

        return try JSONDecoder().decode(FtxResponse<[FtxSubaccount]>.self, from: data)
    }
}
