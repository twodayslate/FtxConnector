import XCTest
@testable import FtxConnector

final class ConnectorTests: XCTestCase {    
    func testTime() async throws {
        let time = try await FtxConnector.time()
        XCTAssertNotNil(time)
    }
}
