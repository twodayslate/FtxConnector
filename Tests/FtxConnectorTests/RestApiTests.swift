import XCTest
@testable import FtxConnector

final class RestApiTests: XCTestCase {
    var client: FtxRestApiClient!
    
    override func setUp() {
        super.setUp()
        self.client = FtxConnector.restClient(key: ProcessInfo.processInfo.environment["FTX_KEY"]!, secret: ProcessInfo.processInfo.environment["FTX_SECRET"]!)
    }
    
    func testAccount() async throws {
        let account = try await client.account()
        XCTAssertNotNil(account)
    }
    
    func testPositions() async throws {
        let positions_avg_price = try await client.positions(showAvgPrice: true)
        XCTAssertNotNil(positions_avg_price)
        
        let positions = try await client.positions(showAvgPrice: false)
        XCTAssertNotNil(positions)
    }
    
    func testSubaccounts() async throws {
        let subaccounts = try await self.client.subaccounts()
        XCTAssertNotNil(subaccounts)
    }
}
